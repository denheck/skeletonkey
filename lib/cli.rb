require 'thor'
require '../lib/safe.rb'
require '../lib/password.rb'

module Lockbox
  class Cli < Thor
    desc "add KEY", "add a new password for KEY"
    def add(key)
      password = STDIN.gets.chomp
      Safe.add(key, Password.fromString(password))
    end

    desc "remove KEY", "remove a password for KEY"
    def remove(key)
      Safe.remove(key)
    end

    desc "get KEY", "retrieve a password for KEY"
    def get(key)
      puts Safe.get(key)
    end
  end
end
