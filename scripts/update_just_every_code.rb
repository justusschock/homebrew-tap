#!/usr/bin/env ruby

require "digest"
require "json"
require "open-uri"
require "optparse"

module JustEveryCodeUpdater
  RELEASE_API_URL = "https://api.github.com/repos/just-every/code/releases/latest".freeze
  RELEASE_BASE_URL = "https://github.com/just-every/code/releases/download".freeze
  USER_AGENT = "justusschock-homebrew-tap-updater".freeze
  ASSETS = %w[
    code-aarch64-apple-darwin.tar.gz
    code-x86_64-apple-darwin.tar.gz
    code-aarch64-unknown-linux-musl.tar.gz
    code-x86_64-unknown-linux-musl.tar.gz
  ].freeze

  module_function

  def update(formula_path:, release_json_path: nil, asset_dir: nil)
    formula = File.read(formula_path)
    release = JSON.parse(release_json_path ? File.read(release_json_path) : fetch_release)
    tag = release.fetch("tag_name")
    version_match = tag.match(/\Av(\d+\.\d+\.\d+)\z/)
    raise ArgumentError, "unsupported release tag: #{tag}" unless version_match

    version = version_match[1]
    current_tags = formula.scan(
      %r{https://github\.com/just-every/code/releases/download/(v\d+\.\d+\.\d+)/code-[^"]+\.tar\.gz},
    ).flatten.uniq
    raise ArgumentError, "formula must reference exactly one release tag" unless current_tags.length == 1

    return { version: version, changed: false } if current_tags.first == tag

    assets = release.fetch("assets").each_with_object({}) do |asset, result|
      name = asset.fetch("name")
      raise ArgumentError, "duplicate release asset: #{name}" if result.key?(name)

      result[name] = asset
    end

    updates = ASSETS.map do |name|
      asset = assets[name]
      raise ArgumentError, "missing release asset: #{name}" unless asset

      url = "#{RELEASE_BASE_URL}/#{tag}/#{name}"
      [name, url, asset_sha256(asset, asset_dir)]
    end

    updated_formula = formula.dup
    updates.each do |name, url, sha256|
      pattern = /(url ")[^"]+\/#{Regexp.escape(name)}("\n\s+sha256 ")[0-9a-f]{64}(")/
      raise ArgumentError, "formula entry missing or duplicated: #{name}" unless updated_formula.scan(pattern).length == 1

      updated_formula.sub!(pattern) do
        match = Regexp.last_match
        "#{match[1]}#{url}#{match[2]}#{sha256}#{match[3]}"
      end
    end

    File.write(formula_path, updated_formula)
    { version: version, changed: true }
  end

  def fetch_release
    headers = {
      "Accept" => "application/vnd.github+json",
      "User-Agent" => USER_AGENT,
      "X-GitHub-Api-Version" => "2022-11-28",
    }
    token = ENV["GITHUB_TOKEN"]
    headers["Authorization"] = "Bearer #{token}" unless token.nil? || token.empty?
    URI.open(RELEASE_API_URL, headers, &:read)
  end

  def asset_sha256(asset, asset_dir)
    if asset_dir
      path = File.join(asset_dir, asset.fetch("name"))
      raise ArgumentError, "missing downloaded asset: #{path}" unless File.file?(path)

      return Digest::SHA256.file(path).hexdigest
    end

    digest = Digest::SHA256.new
    URI.open(asset.fetch("browser_download_url"), "User-Agent" => USER_AGENT) do |io|
      while (chunk = io.read(1024 * 1024))
        digest.update(chunk)
      end
    end
    digest.hexdigest
  end
end

if $PROGRAM_NAME == __FILE__
  options = {
    formula_path: File.expand_path("../Formula/just-every-code.rb", __dir__),
  }

  OptionParser.new do |parser|
    parser.on("--formula PATH") { |path| options[:formula_path] = path }
    parser.on("--release-json PATH") { |path| options[:release_json_path] = path }
    parser.on("--asset-dir PATH") { |path| options[:asset_dir] = path }
  end.parse!

  result = JustEveryCodeUpdater.update(**options)
  puts "version=#{result[:version]}"
  puts "changed=#{result[:changed]}"
end
