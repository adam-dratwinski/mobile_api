class Offer
  attr_accessor :title, :payout, :thumbnail

  def initialize params = {}
    @title     = params[:title]
    @payout    = params[:payout]
    @thumbnail = params[:thumbnail]
  end

  def self.find(params)
    offers = OfferApi.load_offers(params)
    offers.map { |offer| Offer.new(offer) }
  end
end
