require 'nokogiri'
require 'open-uri'
require 'pry'
require 'watir'
require 'webdrivers'
require 'xvfb'

class Scraper 
  def scrape_site_for_categories(url)
    categories = []
    site = Nokogiri::HTML(open(url))
    site = site.css(".vertical-middle")
    site.each do |category|
      categories << {category.text.strip => category.css("a").attribute("href").value} 
    end
    categories
  end
  
  def scrape_category_for_list(categrory)
    item_list = []
    site = Nokogiri::HTML(open(categrory))
    site = site.css(".zoom-anim-parent")
    site.each do |item|
      item_list << {item.css("div div div h4").text => item.css("a").attribute("href").value}
    end
    item_list
  end
  
  def scrape_nutrition_info(item)
    nutrition_list = []
    site = Nokogiri::HTML(open(item))
    sleep 10
    site = site.css(".nutrition-numbers")
    binding.pry
  end
  
  def test 
    mock = Watir::Browser.new :chrome, headless: true
    mock_site = mock.start 'https://www.mcdonalds.com/us/en-us/product/quarter-pounder-with-cheese.html'
    site = Nokogiri::HTML.parse(mock_site.html)
    binding.pry
    #site.css("div.numbers span")[0].text  -- this should give me calories

  end
end

