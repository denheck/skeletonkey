module Lockbox
  DIRECTORY = File.join(Dir.home, ".lockbox")

  class Safe
    def initialize()
      Dir.mkdir(Lockbox::DIRECTORY) unless Dir.exists?(Lockbox::DIRECTORY)

      @file = File.join(Lockbox::DIRECTORY, "safe")
      @storage = {}

      reload
    end

    def add(key, password)
      @storage[key] = password.to_hash
      update
    end

    def get(key)
      Password.fromHash(@storage[key])
    end

    def remove(key)
      @storage.delete(key)
      update
    end

    def list
      @storage.keys * "\n"
    end

    private

    def reload
      @storage =  {}

      return if !File.exists?(@file)

      File.open(@file, 'r') do |file|
        @storage = Marshal.load(file)
      end
    end

    def update
      File.open(@file, 'w', 0600) do |file|
        file << Marshal.dump(@storage)
      end
    end
  end
end
