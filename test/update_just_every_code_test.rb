require "digest"
require "fileutils"
require "json"
require "minitest/autorun"
require "tmpdir"

class UpdateJustEveryCodeTest < Minitest::Test
  REPO_ROOT = File.expand_path("..", __dir__)
  SCRIPT_PATH = File.join(REPO_ROOT, "scripts", "update_just_every_code.rb")
  WORKFLOW_PATH = File.join(REPO_ROOT, ".github", "workflows", "update-just-every-code.yml")
  FORMULA_PATH = File.join(REPO_ROOT, "Formula", "just-every-code.rb")

  ASSETS = %w[
    code-aarch64-apple-darwin.tar.gz
    code-x86_64-apple-darwin.tar.gz
    code-aarch64-unknown-linux-musl.tar.gz
    code-x86_64-unknown-linux-musl.tar.gz
  ].freeze

  def test_updates_all_platform_urls_and_checksums
    updater = load_updater

    Dir.mktmpdir do |dir|
      formula_path = File.join(dir, "just-every-code.rb")
      release_path = File.join(dir, "release.json")
      asset_dir = File.join(dir, "assets")
      FileUtils.cp(FORMULA_PATH, formula_path)
      FileUtils.mkdir_p(asset_dir)

      assets = ASSETS.map do |name|
        File.write(File.join(asset_dir, name), "v0.6.157:#{name}")
        {
          "name" => name,
          "browser_download_url" => "https://example.invalid/#{name}",
        }
      end
      File.write(release_path, JSON.generate("tag_name" => "v0.6.157", "assets" => assets))

      result = updater.update(
        formula_path: formula_path,
        release_json_path: release_path,
        asset_dir: asset_dir,
      )

      assert_equal({ version: "0.6.157", changed: true }, result)

      formula = File.read(formula_path)
      refute_includes formula, "/download/v0.6.156/"
      ASSETS.each do |name|
        expected_sha = Digest::SHA256.file(File.join(asset_dir, name)).hexdigest
        assert_includes formula, "/download/v0.6.157/#{name}"
        assert_match(/#{Regexp.escape(name)}"\n\s+sha256 "#{expected_sha}"/, formula)
      end
    end
  end

  def test_current_release_is_a_no_op_without_downloading_assets
    updater = load_updater

    Dir.mktmpdir do |dir|
      formula_path = File.join(dir, "just-every-code.rb")
      release_path = File.join(dir, "release.json")
      FileUtils.cp(FORMULA_PATH, formula_path)
      original_formula = File.read(formula_path)
      current_version = original_formula[%r{/download/v(\d+\.\d+\.\d+)/}, 1]
      File.write(release_path, JSON.generate("tag_name" => "v#{current_version}", "assets" => []))

      result = updater.update(
        formula_path: formula_path,
        release_json_path: release_path,
      )

      assert_equal({ version: current_version, changed: false }, result)
      assert_equal original_formula, File.read(formula_path)
    end
  end

  def test_rejects_a_release_missing_a_required_asset
    updater = load_updater

    Dir.mktmpdir do |dir|
      formula_path = File.join(dir, "just-every-code.rb")
      release_path = File.join(dir, "release.json")
      asset_dir = File.join(dir, "assets")
      FileUtils.cp(FORMULA_PATH, formula_path)
      FileUtils.mkdir_p(asset_dir)

      assets = ASSETS.drop(1).map do |name|
        File.write(File.join(asset_dir, name), name)
        {
          "name" => name,
          "browser_download_url" => "https://example.invalid/#{name}",
        }
      end
      File.write(release_path, JSON.generate("tag_name" => "v0.6.157", "assets" => assets))

      error = assert_raises(ArgumentError) do
        updater.update(
          formula_path: formula_path,
          release_json_path: release_path,
          asset_dir: asset_dir,
        )
      end

      assert_match(/missing release asset/, error.message)
    end
  end

  def test_workflow_only_squash_merges_internal_bot_formula_updates
    assert File.exist?(WORKFLOW_PATH), "expected the automatic update workflow to exist"

    workflow = File.read(WORKFLOW_PATH)
    assert_match(/schedule:\n\s+- cron:/, workflow)
    assert_match(/workflow_dispatch:/, workflow)
    assert_match(/contents: write/, workflow)
    assert_match(/pull-requests: write/, workflow)
    assert_includes workflow, "Homebrew/actions/setup-homebrew@9af03b7ae3f9e2ae5c174f659d5c3909f7e7dbac"
    assert_includes workflow, "ruby test/update_just_every_code_test.rb"
    assert_includes workflow, "ruby scripts/update_just_every_code.rb"
    assert_includes workflow, "gh auth setup-git"
    assert_includes workflow, "gh pr create"
    assert_match(/if: steps\.update\.outputs\.changed == 'true'/, workflow)
    assert_includes workflow, '.author.login == "app/github-actions"'
    assert_includes workflow, ".isCrossRepository == false"
    assert_includes workflow, '.headRepositoryOwner.login == "justusschock"'
    assert_includes workflow, '^automation/just-every-code-v[0-9]+[.][0-9]+[.][0-9]+$'
    assert_includes workflow, '[.files[].path] == ["Formula/just-every-code.rb"]'
    assert_includes workflow, 'gh pr merge "$pr_url" --squash'
    refute_match(/^\s*pull_request:/, workflow)
  end

  private

  def load_updater
    assert File.exist?(SCRIPT_PATH), "expected the release updater script to exist"
    require SCRIPT_PATH
    JustEveryCodeUpdater
  end
end
