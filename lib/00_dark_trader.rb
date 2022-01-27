require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))

def get_crypto_name(page)
  names = []
  page.xpath('//a[@class="cmc-table__column-name--symbol cmc-link"]/text()').each do |name|
    puts "retrieving Name #{name}"
    names << name.text
  end
  return names
end

def get_crypto_value(page)
  values = []
  page.xpath('//tbody/tr/td/div/a/span/text()').each do |value|
    puts "retrieving Price #{value}"
    values << value.text
  end
  return values
end

def perform(page)
  names = get_crypto_name(page)
  values = get_crypto_value(page)
  crypto_names_and_values = names.zip(values).each_slice(1).map(&:to_h)
  puts "\nCrypto market : "
  puts ""
  puts crypto_names_and_values
end

perform(page)

