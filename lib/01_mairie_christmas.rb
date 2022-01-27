require 'nokogiri'
require 'open-uri'

#Scrapping du site : http://annuaire-des-mairies.com/

  #récupérer l'email d'une commune

def get_townhall_email(example)
  page = Nokogiri::HTML(URI.open(example))
  email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
  return email
end

  #récupérer l'url des pages de chaque commune du 95

def get_townhall_urls
  page = Nokogiri::HTML(URI.open('https://www.annuaire-des-mairies.com/val-d-oise.html'))
  
  urls = page.xpath('//a[@class="lientxt"]/@href').map{|x| x.text[1..-1]}
  
  urls.length.times do |url|
    urls[url] = "https://www.annuaire-des-mairies.com" + urls[url]
  end
  
  return urls
end

  #récupérer les noms de chaque commune du 95

def get_townhall_names
  page = Nokogiri::HTML(URI.open('https://www.annuaire-des-mairies.com/val-d-oise.html'))
  
  town_names = page.xpath('//a[@class="lientxt"]').map{|x| x.text}
  
  return town_names
end

  #récupérer tous les emails du 95 dans les urls de get_townhall_urls à la position définie dans get_townhall_email

def get_array_of_emails
  
  urls = get_townhall_urls
  emails = urls.map{|url|
  get_townhall_email(url)
  }
  
  return emails
end

def perform
  puts "Retrieving emails..."
  
  emails = get_array_of_emails
  names = get_townhall_names
  townhall_names_and_emails = names.zip(emails).each_slice(1).map(&:to_h)
  
  puts townhall_names_and_emails
end

perform

