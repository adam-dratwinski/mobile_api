require 'spec_helper'

describe OffersController, 'index' do
  let(:offer) { stub(:offer) }

  it "has empty offers array when no params send" do
    get :index
    assigns[:offers].should == []
  end

  it "has offers array when params send" do
    OfferApi.should_receive(:load_offers).with(:uid => "player1", :pub0 => "campaign2", :page => "2").and_return([offer])

    get :index, :offer => { :uid => "player1", :pub0 => "campaign2", :page => 2 }
    assigns[:offers].should have(1).offer
  end
end
