require 'pathname'
require "zenv/version"

module Zenv
  @pathname = Pathname.new '.zenv'

  class << self
    attr_writer :pathname

    private

    attr_reader :pathname, :namespace_loaded

    def load
      namespace = ENV['ZENV']&.to_sym || :default

      if namespace_loaded
        warn "[Zenv] skipping #{namespace.inspect}, already loaded #{namespace_loaded.inspect}"
      end

      unless pathname.exist?
        warn "[Zenv] .zenv file not found"
        return
      end

      data = eval pathname.read

      unless data.key? namespace
        warn "[Zenv] missing #{namespace.inspect} in .zenv"
        return
      end

      data[namespace].each do |key, value|
        ENV[key.to_s] = value
      end

      namespace_loaded = namespace

      puts "[Zenv] loaded #{namespace_loaded.inspect}"
    end
  end

  load
end
