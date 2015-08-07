require 'openssl'
require 'skeletonkey/key_pair'

module Lockbox
  class Password
    attr_accessor :contents, :encrypted_contents, :iv, :key

    class << self
      def valid?(password, confirmed_password, &on_invalid)
        valid = true

        if password != confirmed_password
          on_invalid.call("Your passwords do not match! Please try again")
          valid = false
        elsif password === ''
          on_invalid.call("Your password cannot be empty! Please try again")
          valid = false
        end

        valid
      end

      def fromHash(password_hash)
        password = new
        password.encrypted_contents = password_hash[:encrypted_contents]
        password.key = password_hash[:key]
        password.iv = password_hash[:iv]

        password.decrypt
        password
      end

      def fromString(password_str)
        password = new
        password.contents = password_str

        password.encrypt
        password
      end
    end

    def to_str
      @contents
    end

    def to_hash
      {
        :encrypted_contents => @encrypted_contents,
        :iv => @iv,
        :key => @key
      }
    end

    def encrypt
      cipher.encrypt

      # set random key/iv on cipher, return for public encryption
      # and store encrypted key/iv in instance variables
      @key = KeyPair.public_encrypt(cipher.random_key)
      @iv = KeyPair.public_encrypt(cipher.random_iv)

      @encrypted_contents = cipher.update(@contents) + cipher.final
    end

    def decrypt
      decipher = cipher
      decipher.decrypt

      decipher.key = KeyPair.private_decrypt(@key)
      decipher.iv = KeyPair.private_decrypt(@iv)

      @contents = decipher.update(@encrypted_contents) + decipher.final
    end

    def cipher
      @cipher ||= OpenSSL::Cipher.new('AES-256-CBC')
    end
  end
end
