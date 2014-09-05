require './scraper'

describe Scraper do
  let(:ab) {'ab'}
  let(:scraper) { Scraper.new(ab) }

  context "#page_source" do
    specify "should return page source for Scraper's search text" do
      expect(scraper.page_source.body).to include('ABACUS & CO</a></td><td>22 Jun 1995')
    end
  end

  context "#companies" do
    specify "should return a list of companies starting with 'ab'" do
      expect(scraper.companies).to include(["15776", "RBN", "ABACUS & CO", "22 Jun 1995"])
    end
  end

  context "#num_results" do
    specify "should return the number of results found" do
      expect(Scraper.new('a').num_results).to eq(300)
    end
  end

end # of describe
