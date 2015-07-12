require 'thor'
require 'io/console'
require '../lib/safe.rb'
require '../lib/password.rb'

module Lockbox
  class Cli < Thor
    def initialize(*args)
      super(*args)

      @safe ||= Safe.new
    end

    desc "add KEY", "add a new password for KEY"
    def add(key)
      puts "Please Enter a Password for #{key}:"
      STDIN.noecho do |io|
        @safe.add(key, Password.fromString(io.gets.chomp))
      end
    end

    desc "remove KEY", "remove a password for KEY"
    def remove(key)
      @safe.remove(key)
    end

    desc "get KEY", "retrieve a password for KEY"
    def get(key)
      puts @safe.get(key)
    end

    desc "list", "list all KEYs"
    def list
      puts @safe.list
    end
  end
end
