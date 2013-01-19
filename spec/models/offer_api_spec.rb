require "spec_helper" 

describe OfferApi do
  let(:user_id)	    { stub(:user_id) }
  let(:timestamp)   { stub(:timestamp) }
  let(:pub0)	    { stub(:pub0) }
  let(:page)	    { stub(:pate) }

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

  subject { OfferApi.new }

  describe ".generate_hash" do
    it "generates proper hash" do
      OfferApi.generate_hash(data, api_key).should == "7a2b1604c03d46eec1ecd4a686787b75dd693c4d"
    end
  end

  describe ".generate_api_url" do
    it "generates proper api url" do
      Time.stub(:now => "2012-01-01 00:00:00")

      OfferApi.generate_api_url(data, api_key).should == "http://api.sponsorpay.com/feed/v1/offers.json?appid=157&uid=player1&ip=212.45.111.17&locale=de&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ps_time=1312211903&pub0=campaign2&page=2&timestamp=2012&hashkey=6bee3edf87206e0af62f13ded86c3d129d01c39b"
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
      response = OfferApi.load( :uid => "player1", :pub0 => "campaign2", :page => 2)
      response["code"].should == "OK"
      response["message"].should == "Ok"
    end
  end
end
