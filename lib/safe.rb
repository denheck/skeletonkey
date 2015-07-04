module Lockbox
  class Safe
    class << self
      SAFE_FILE = '../data/safe'

      def add(key, password)
        reload
        @storage[key] = password.to_hash
        flush
      end

      def get(key)
        reload
        Password.fromHash(@storage[key]).to_str
      end

      def remove(key)
        reload
        @storage.delete(key)
        flush
      end

      private

      def reload
        @storage =  {}

        return if !File.exists?(SAFE_FILE)

        File.open(SAFE_FILE, 'r') do |file|
          @storage = Marshal.load(file)
        end
      end

      def flush
        if File.exists?(SAFE_FILE)
          File.delete(SAFE_FILE)
        end

        File.open(SAFE_FILE, 'w', 0600) do |file|
          file << Marshal.dump(@storage)
        end

        @storage = {}
      end
    end
  end
end
