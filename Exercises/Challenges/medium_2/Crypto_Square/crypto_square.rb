# require 'pry'
class Crypto
  def initialize(message)
    @message = message
    normalize_plaintext
  end

  def normalize_plaintext
    @message = @message.delete('^a-zA-Z0-9').downcase
  end

  def size
    Math.sqrt(@message.size).ceil
  end

  def plaintext_segments
    normalize_plaintext.scan(/.{1,#{size}}/)
  end

  def ciphertext
    cipher_array.join('')
  end

  def normalize_ciphertext
    cipher_array.join(' ')
  end

  private

  def cipher_array
    segments = plaintext_segments
    iterations = segments.first.size
    result = Array.new(iterations) { String.new }
    iterations.times do |idx|
      segments.each do |segment|
        break unless segment[idx]
        result[idx] << segment[idx]
      end
    end
    result
  end
end

# crypto = Crypto.new('Never vex thine heart with idle woes')
# p %w(neverv exthin eheart withid lewoes)
# p crypto.plaintext_segments