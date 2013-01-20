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
end
