require 'mechanize'

class Scraper

  URL = 'https://www.jerseyfsc.org/registry/documentsearch/'
  CATEGORY_FIELD = 'ctl00$Main$statusCategoryComboBox'
  SEARCH_TYPE_FIELD = 'ctl00$Main$searchTypesComboBox'
  CATEGORIES = {all: '0', active: '2', inactive: '4'}
  TYPE = 'BeginsWith'
  SEARCH_TEXT_FIELD = 'ctl00$Main$txtSearch'
  TABLE = 'Main_ResultsGrid'

  attr_reader :agent, :search_text

  def initialize(search_text)
    @agent = Mechanize.new
    @search_text = search_text
  end

  def companies
    results.collect { |row| row.css('td').collect { |i| i.text } }
  end

  def num_results
    results.size
  end

  def results
    page_source.search("//table[@id='Main_ResultsGrid']/tr")[1..-1]
  end

  def page_source
    home_page = @agent.get(URL)
    form = home_page.form
    form.send(SEARCH_TYPE_FIELD, TYPE)
    form.send(CATEGORY_FIELD, CATEGORIES[:active])
    form.send(SEARCH_TEXT_FIELD, search_text) # ditto
    @agent.submit(form, form.buttons.first)
  end

end
