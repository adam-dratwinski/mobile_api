require "spec_helper" 

describe OfferApi::Params do
  subject { OfferApi::Params.new(data, api_key) }

  let(:api_key) { "e95a21621a1865bcbae3bee89c4d4f84" }

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

  its(:generate_hash)    { should == "7a2b1604c03d46eec1ecd4a686787b75dd693c4d" }
  its(:generate_api_url) { should == "http://api.sponsorpay.com/feed/v1/offers.json?timestamp=1312553361&appid=157&uid=player1&ip=212.45.111.17&locale=de&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ps_time=1312211903&pub0=campaign2&page=2&hashkey=7a2b1604c03d46eec1ecd4a686787b75dd693c4d" }
end
