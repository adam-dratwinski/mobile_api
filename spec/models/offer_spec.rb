require "spec_helper" 

class OfferApi
end

describe Offer do
  let(:title)	  { stub(:title) }
  let(:payout)    { stub(:payout) }
  let(:thumbnail) { stub(:thumbnail) }

  let(:params) { { 
    :title => title,
    :payout => payout,
    :thumbnail => thumbnail 
  } }

  subject { Offer.new(params) }

  describe ".new" do
    its(:title)     { should == title }
    its(:payout)    { should == payout }
    its(:thumbnail) { should == thumbnail }
  end

  it "finds offers" do
    OfferApi.should_receive(:load_offers).with(params).and_return([params])

    offer = Offer.find(params)[0]

    offer.title.should     == title
    offer.payout.should    == payout
    offer.thumbnail.should == thumbnail
  end

  it "doesn't try to find offers if no params send" do
    OfferApi.should_not_receive(:load_offers)

    Offer.find({}).should == []
  end
end
