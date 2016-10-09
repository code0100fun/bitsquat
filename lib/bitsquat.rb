require "bitsquat/version"

module Bitsquat
  def self.list(url)
    list = []
    uri = parse_url(url)
    host = uri.host.downcase
    segments = host.split('.')
    tld = segments[-1]
    domain = segments[-2]
    subdomains = segments.reverse[2..-1]
    subdomain = subdomains.first
    if subdomain
      list << "#{subdomain}n#{domain}.#{tld}"
    end
    domain.length.times do |i|
      flipped_domains = flip_bits(domain, i)
      flipped_domains.each do |flipped_domain|
        list << "#{flipped_domain}.#{tld}"
      end
    end
    list
  rescue URI::Error => e
    []
  end

  private

  def self.flip_bits(str, char_index)
    str_bits = str.split('').map { |c| c.unpack('B*').first }.freeze
    char_bits = str_bits[char_index].split('').map(&:to_i).freeze
    char_bits.each_with_index.map do |b, i|
      char_bits_dup = char_bits.dup
      char_bits_dup[i] = [1,0][b]
      str_bits_dup = str_bits.dup
      new_char = char_bits_dup.join('')
      new_char_code = new_char.to_i(2)
      if ((new_char_code >= 48 && new_char_code <= 57) || # 0-9
          (new_char_code >= 97 && new_char_code <= 122) || # a-z
           new_char_code == 45) # -
        str_bits_dup[char_index] = new_char
        [str_bits_dup.join('')].pack('B*')
      end
    end.compact
  end

  def self.parse_url(url)
    unless url.match(/^(https:\/\/|http:\/\/)/)
      url = "https://#{url}"
    end
    URI.parse(url)
  end
end
