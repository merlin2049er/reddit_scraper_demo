class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  class Entry
    def initialize(title, link)
      @title = title
      @link = link
    end
    attr_reader :title
    attr_reader :link
  end


  def scrape_reddit
    #require 'nokogiri'
    require 'open-uri'

    # url = "https://www.reddit.com/r/all"
     url = "https://www.reddit.com/"

    doc = Nokogiri::HTML(open(url, 'User-Agent' => 'Nooby'))
    #render plain: doc

    entries = doc.css('.entry')
    @entriesArray = []
    entries.each do |entry|
      title = entry.css('p.title>a').text
      link = entry.css('p.title>a')[0]['href']
      @entriesArray << Entry.new(title, link)
    end

    # We'll just try to render the array and see what happens
    #render plain: entriesArray
    render template: 'scrape_reddit'


  end

end
