module Lockbox
  class KeyPair
    class << self
      def generate
        return if File.exists?(private_key_path) && File.exists?(public_key_path)

        key = OpenSSL::PKey::RSA.new 2048

        File.open(private_key_path, 'w', 0600) do |file|
          file.write(key.to_pem)
        end

        File.open(public_key_path, 'w', 0600) do |file|
          file.write(key.public_key.to_pem)
        end
      end

      def public_encrypt(data)
        generate
        key = OpenSSL::PKey::RSA.new(File.read(public_key_path))
        key.public_encrypt(data)
      end

      def private_decrypt(data)
        generate
        key = OpenSSL::PKey::RSA.new(File.read(private_key_path))
        key.private_decrypt(data)
      end

      private

      def private_key_path
        File.join(Lockbox::DIRECTORY, "private_key.pem")
      end

      def public_key_path
        File.join(Lockbox::DIRECTORY, "public_key.pem")
      end
    end
  end
end
