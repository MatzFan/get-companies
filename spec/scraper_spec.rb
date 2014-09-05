require './scraper'

describe Scraper do
  let(:ab) {'ab'}
  let(:scraper) { Scraper.new(ab) }

  context "#get_companies" do
    specify "should return a list of companies starting with 'ab'" do
      expect(scraper.get_companies).to eq([])
    end
  end

end # of describe
