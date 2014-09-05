require './scraper'

describe Scraper do
  let(:ab) {'ab'}
  let(:scraper) { Scraper.new(ab) }
  let(:cp_example) { 'JERSEY HOMEBUILDERS LIMITED' }
  let(:rbn_example) { 'jersey hosting' }

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

  context "#row_link" do
    specify "should return nil if there is no link (type is CP)" do
      s = Scraper.new(cp_example)
      expect(s.row_link(s.results[0])).to be nil
    end

    specify "should return link id name for a RBN" do
      s = Scraper.new(rbn_example)
      expect(s.row_link(s.results[0])).to eq(Scraper::DELIM + '119287')
    end
  end

  context "#companies_data" do
    specify "should return list of company data with id (empty for a CP)" do
      expect(Scraper.new(cp_example).company_data[0]).to eq(
        ["", "103334", "CP", "JERSEY HOMEBUILDERS LIMITED", "12 Mar 2014"])
    end

    specify "should return list of company data with id (valid for a RBN)" do
      expect(Scraper.new(rbn_example).company_data[0]).to eq(
        ["119287", "23030", "RBN", "JERSEY HOSTING", "25 Jul 2006"])
    end
  end

  context "#previous_name?" do
    specify "should return false if the name is current" do
      s = Scraper.new('jersey hot tubs')
      expect(s.previous_name?(s.results[0])).to be false
      expect(s.previous_name?(s.results[1])).to be true
    end
  end

end # of describe
