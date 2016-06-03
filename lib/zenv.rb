require "zenv/version"

module Zenv
  def self.load
    namespace = ENV['ZENV']&.to_sym || :default

    if @namespace_loaded
      warn "[Zenv] skipping #{namespace.inspect}, already loaded #{@namespace_loaded.inspect}"
    end

    filename = '.zenv'

    unless File.exist? filename
      warn "[Zenv] .zenv file not found"
      return
    end

    data = begin
      filepath = File.expand_path filename
      ruby_code = File.read filepath
      eval ruby_code
    end

    unless data.key? namespace
      warn "[Zenv] missing #{namespace.inspect} in .zenv"
      return
    end

    data[namespace].each do |key, value|
      ENV[key.to_s] = value
    end

    @namespace_loaded = namespace

    puts "[Zenv] loaded #{@namespace_loaded.inspect}"

    @namespace_loaded
  end
end

Zenv.load
