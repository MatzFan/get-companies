require './jersey_scraper'

describe JerseyScraper do
  let(:ab) {'ab'}
  let(:scraper) { JerseyScraper.new(ab) }
  let(:cp_example) { 'ABBVIE GROUP PLC' }
  let(:rbn_example) { 'jersey hosting' }

  context "#page_source" do
    specify "should return page source for Scraper's search text" do
      expect(scraper.page_source.body).to include('ABACUS & CO</a></td><td>22 Jun 1995')
    end
  end

  context "#companies" do
    specify "should return a list of companies starting with 'ab'" do
      expect(scraper.companies).to include(["15776", "RBN", "ABACUS & CO", "22/06/1995"])
    end
  end

  context "#num_results" do
    specify "should return the number of results found" do
      expect(JerseyScraper.new('a').num_results).to eq(300)
    end
  end

  context "#row_link" do
    specify "should return nil if there is no link (type is CP)" do
      s = JerseyScraper.new(cp_example)
      expect(s.row_link(s.results[0])).to be nil
    end

    specify "should return link id name for a RBN" do
      s = JerseyScraper.new(rbn_example)
      expect(s.row_link(s.results[0])).to eq(JerseyScraper::DELIM + '119287')
    end
  end

  context "#companies_data" do
    specify "should return list of company data with id (empty for a CP)" do
      expect(JerseyScraper.new(cp_example).company_data[0]).to eq(
        ['', '105919', 'CP', 'ABBVIE GROUP PLC', '09/07/2014', 'false'])
    end

    specify "should return list of company data with id (valid for a RBN)" do
      expect(JerseyScraper.new(rbn_example).company_data[0]).to eq(
        ['119287', '23030', 'RBN', 'JERSEY HOSTING', '25/07/2006', 'false'])
    end
  end

  context "#previous_names" do
    specify "should return false if the name is current" do
      expect(JerseyScraper.new('jersey hot tubs').previous_names).to eq(['false', 'true'])
    end
  end

end # of describe
