class Scraper

  URL = 'https://www.jerseyfsc.org/registry/documentsearch/'

  attr_reader :search_text

  def initialize(search_text)
    @search_text = search_text
  end

  def get_companies
    []
  end

end
