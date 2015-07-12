require 'thor'
require 'clipboard'
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
    option :copy, :type => :boolean
    def get(key)
      password = @safe.get(key).to_str

      if options[:copy]
        Clipboard.copy(password)
      else
        puts password
      end
    end

    desc "list", "list all KEYs"
    def list
      puts @safe.list
    end
  end
end
