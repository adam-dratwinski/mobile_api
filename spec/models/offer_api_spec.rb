require "spec_helper" 

describe OfferApi do
  let(:data) { {
    :appid     => '157',
    :uid       => 'player1',
    :ip        => '212.45.111.17',
    :locale    => 'de',
    :device_id => '2b6f0cc904d137be2e1730235f5664094b831186',
    :ps_time   => '1312211903',
    :pub0      => 'campaign2',
    :page      => '2',
    :timestamp => '1312553361'
  } }

  let(:default_data) { {
    'appid'       => '157',
    'format'      => 'json',
    'device_id'   => '2b6f0cc904d137be2e1730235f5664094b831186',
    'locale'      => 'de',
    'ip'          => '212.45.111.17',
    'offer_types' => '112'
  } }

  let(:api_key) { "e95a21621a1865bcbae3bee89c4d4f84" }

  describe ".generate_hash" do
    it "generates proper hash" do
      OfferApi.generate_hash(data, api_key).should == "7a2b1604c03d46eec1ecd4a686787b75dd693c4d"
    end
  end

  describe ".generate_api_url" do
    it "generates proper api url" do
      Timecop.freeze("2013-01-19 22:50")

      OfferApi.generate_api_url(data, api_key).should == "http://api.sponsorpay.com/feed/v1/offers.json?appid=157&uid=player1&ip=212.45.111.17&locale=de&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ps_time=1312211903&pub0=campaign2&page=2&timestamp=1358635800&hashkey=27bf62140fcf329f807ad635bfc800d266c18892"
    end
  end

  describe ".load_default_params" do
    let(:config) { { "offer_api" => default_data } }

    it "loads params from config" do
      YAML.should_receive(:load).and_return(config)
      OfferApi.config.should == default_data.symbolize_keys
    end
  end

  describe ".load" do
    it "creates request" do
      Timecop.freeze("2013-01-19 22:50")

      VCR.use_cassette('load') do
        response = OfferApi.load( :uid => "player1", :pub0 => "campaign2", :page => 2)
        response["code"].should == "OK"
        response["message"].should == "Ok"
      end
    end
  end

  describe ".offers" do
    Timecop.freeze("2013-01-19 22:50")

    VCR.use_cassette('load_offers') do
      offers = OfferApi.load_offers( :uid => "player1", :pub0 => "campaign2", :page => 2)

      offers[0][:title].should  == "o2 Gratis Prepaid-Karte mit Bonus" 
      offers[0][:payout].should == 54085 
      offers[0][:thumbnail].should == {
        "lowres"=> "http://cdn3.sponsorpay.com/assets/15196/offerwall-02_square_60.jpg",
        "hires"=> "http://cdn3.sponsorpay.com/assets/15196/offerwall-02_square_175.jpg"
      }
    end
  end
end
