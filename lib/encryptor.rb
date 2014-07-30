require 'base64'

class Encryptor
  def self.public_key
    OpenSSL::PKey::RSA.new File.read(Rails.root + "public/crypt/public.pem")
  end

  def self.private_key
    OpenSSL::PKey::RSA.new File.read(Rails.root + "config/private.pem"), ENV['PK_PASSPHRASE']
  end

  def self.encrypt(string)
    Base64.urlsafe_encode64 public_key.public_encrypt(string)
  end

  def self.decrypt(string)
    private_key.private_decrypt Base64.urlsafe_decode64(string)
  end
end