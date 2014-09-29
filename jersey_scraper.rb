require 'mechanize'

class JerseyScraper

  URL = 'https://www.jerseyfsc.org/registry/documentsearch/'
  CATEGORY_FIELD = 'ctl00$Main$statusCategoryComboBox'
  SEARCH_TYPE_FIELD = 'ctl00$Main$searchTypesComboBox'
  PREVIOUS_NAMES_FIELD = 'ctl00$Main$previousNamesCheckBox'
  CATEGORIES = {all: '0', active: '2', inactive: '4'}
  TYPE = 'BeginsWith'
  SEARCH_TEXT_FIELD = 'ctl00$Main$txtSearch'
  TABLE_ID = 'Main_ResultsGrid'
  DELIM = 'NameDetail.aspx?Id='

  attr_reader :agent, :search_text

  def initialize(search_text)
    @agent = Mechanize.new
    @search_text = search_text
  end

  def company_data
    id_s.zip(companies).map { |e| e.flatten }.zip(previous_names).map do |e|
      e.flatten
    end
  end

  def companies
    datify(results.collect { |r| r.css('td').collect { |e| e.text.strip } })
  end

  def datify(arr)
    arr.map! { |e| e = e[0..-2] << Date.parse(e.last).strftime('%d/%m/%Y') }
  end

  def id_s
    results.collect do |row|
      row_link(row) ? row_link(row).split(DELIM).last : ''
    end
  end

  def row_link(row)
    begin
      row.css('td')[0].css('a').attribute('href').value
    rescue
      nil
    end
  end

  def previous_names
    results.collect { |row| (row.attr('class') == " previousName").to_s }
  end

  def num_results
    results.size
  end

  def results
    page_source.search("//table[@id='#{TABLE_ID}']/tr")[1..-1] || [] # if nothing found
  end

  def page_source
    home_page = @agent.get(URL)
    form = home_page.form
    form.send(SEARCH_TYPE_FIELD, TYPE)
    form.send(CATEGORY_FIELD, CATEGORIES[:active])
    form.send(SEARCH_TEXT_FIELD, search_text)
    form.add_field!(PREVIOUS_NAMES_FIELD, value = 'on')
    @agent.submit(form, form.buttons.first)
  end

end

# s = JerseyScraper.new('fo')
# p s.companies[5]

