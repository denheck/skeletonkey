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
      STDIN.noecho do |io|
        puts "Please Enter a Password for #{key}: "
        first_attempt = io.gets.chomp

        puts "Please confirm your password: "
        second_attempt = io.gets.chomp

        on_invalid = ->(message){ puts message }

        if Password.valid?(first_attempt, second_attempt, &on_invalid)
          @safe.add(key, Password.fromString(first_attempt))
        end
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
