require 'openssl'
require 'Base64'
require 'digest/sha1'

module GridCLI
  class Crypt
    def self.generate_token(username)
      Crypt.sha(Crypt.encrypt(username))
    end

    # encrypt with private
    def self.encrypt(text)
      priv = OpenSSL::PKey::RSA.new(Crypt.private_key)
      Base64::encode64 priv.private_encrypt(text)
    end

    def self.private_key
      File.read File.expand_path(GridCLI.config['privatekey'])
    end

    def self.public_key
      File.read File.expand_path(GridCLI.config['publickey'])
    end

    def self.sha(text)
      Digest::SHA1.hexdigest text
    end
  end
end
