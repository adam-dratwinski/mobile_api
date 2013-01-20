require "spec_helper" 

describe OfferApi do
  before { Timecop.freeze("2013-01-19 22:50") }

  let(:params) { { :uid => "player1", :pub0 => "campaign2", :page => 2 } }

  subject { OfferApi.new(params) }

  describe "#load_offers" do
    context "when some params passed" do
      before do
        VCR.use_cassette('load_offers') do
          @offers = subject.load_offers
          @first_offer = @offers[0]
        end
      end

      it "has offers" do
        @offers.should have(19).offers
      end
        
      it "has a title" do
        @first_offer.title.should == "Modern War" 
      end

      it "has a payout number" do
        @first_offer.payout.should == 2373
      end

      it "has a thumbnail" do
        @first_offer.thumbnail.should  == {
          "lowres" =>"http://cdn2.sponsorpay.com/assets/17744/icon_mobile_square_60.png",
          "hires"  =>"http://cdn2.sponsorpay.com/assets/17744/icon_mobile_square_175.png"
        }
      end
    end

    context "when no params passed" do
      let(:params) { {} }

      it "not receives load" do
        OfferApi.should_not_receive(:request)
        subject.load_offers
      end

      it "returns an empty array" do
        subject.load_offers.should == []
      end
    end
  end

  describe ".config" do
    let(:default_data) { { "api_key" => stub } }
    let(:config) { { "offer_api" => default_data } }

    it "loads params from config" do
      YAML.should_receive(:load).and_return(config)
      OfferApi.config.should == default_data.symbolize_keys
    end
  end

  describe ".load_offers" do
    it "calls initializer with params and load_offers" do
      instance = stub(:instance)
      OfferApi.should_receive(:new).with(params).and_return(instance)
      instance.should_receive(:load_offers)

      OfferApi.load_offers(params)
    end
  end

  it "should validate response" do
    subject.stub(:check_response => false)

    VCR.use_cassette('load_offers') do
      expect { subject.load_offers }.to raise_error(OfferApi::BadSignatureException)
    end
  end
end
