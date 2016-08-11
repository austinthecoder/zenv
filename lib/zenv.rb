require 'pathname'

module Zenv
  @available_pathnames = [
    Pathname.new('.zenv'),
    Pathname.new('.zenv.rb'),
  ].freeze

  class << self
    def version
      '1.1.0'
    end

    private

    attr_reader :available_pathnames, :namespace_loaded

    def load
      namespace = ENV['ZENV']&.to_sym || :default

      if namespace_loaded
        warn "[Zenv] skipping #{namespace.inspect}, already loaded #{namespace_loaded.inspect}"
      end

      pathname = available_pathnames.find(&:exist?)

      unless pathname
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

      @namespace_loaded = namespace

      puts "[Zenv] loaded #{namespace_loaded.inspect}"
    end
  end

  load
end
