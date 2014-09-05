require 'mechanize'

class Scraper

  URL = 'https://www.jerseyfsc.org/registry/documentsearch/'
  BEGINS = 'BeginsWith'
  SEARCH_TYPE_FIELD = 'ctl00$Main$searchTypesComboBox'
  SEARCH_TEXT_FIELD = 'ctl00$Main$txtSearch'

  attr_reader :agent, :search_text

  def initialize(search_text)
    @agent = Mechanize.new
    @search_text = search_text
  end

  def get_companies
    []
  end

  def page_source
    home_page = @agent.get(URL)
    form = home_page.form
    form.send(SEARCH_TYPE_FIELD, BEGINS)
    form.send(SEARCH_TEXT_FIELD, search_text) # ditto
    @agent.submit(form, form.buttons.first).body
  end

end

# puts Scraper.new('ab').page_source.body
