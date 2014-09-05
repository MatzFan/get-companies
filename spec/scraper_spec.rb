require './scraper'

describe Scraper do
  let(:ab) {'ab'}
  let(:scraper) { Scraper.new(ab) }

  context "#page_source" do
    specify "should return page source for Scraper's search text" do
      expect(scraper.page_source.body).to include('ABACUS & CO</a></td><td>22 Jun 1995')
    end
  end

  context "#get_companies" do
    specify "should return a list of companies starting with 'ab'" do
      expect(scraper.get_companies).to include(["15776", "RBN", "ABACUS & CO", "22 Jun 1995"])
    end
  end

end # of describe
