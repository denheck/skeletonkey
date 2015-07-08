require 'thor'
require 'io/console'
require '../lib/safe.rb'
require '../lib/password.rb'

module Lockbox
  class Cli < Thor
    desc "add KEY", "add a new password for KEY"
    def add(key)
      puts "Please Enter a Password for #{key}:"
      STDIN.noecho do |io|
        Safe.add(key, Password.fromString(io.gets.chomp))
      end
    end

    desc "remove KEY", "remove a password for KEY"
    def remove(key)
      Safe.remove(key)
    end

    desc "get KEY", "retrieve a password for KEY"
    def get(key)
      puts Safe.get(key)
    end

    desc "list", "list all KEYs"
    def list
      puts Safe.list
    end
  end
end
