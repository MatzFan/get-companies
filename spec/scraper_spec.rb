require './scraper'

describe Scraper do
  let(:ab) {'ab'}
  let(:scraper) { Scraper.new(ab) }

  context "#page_source" do
    specify "should return page source for Scraper's search text" do
      expect(scraper.page_source).to include('46541">ABACUS INVESTMENTS')
    end
  end

  context "#get_companies" do
    specify "should return a list of companies starting with 'ab'" do
      expect(scraper.get_companies).to eq([])
    end
  end

end # of describe
