class Offer
  attr_accessor :title, :payout, :thumbnail

  def initialize params
    @title     = params[:title]
    @payout    = params[:payout]
    @thumbnail = params[:thumbnail]
  end

  def self.find(params)
    offer_params = {
      :title     => "Offer Title",
      :payout    => "Offer Payout",
      :thumbnail => "Offer Thumbnail"
    }

    offers = []
    offers << Offer.new(offer_params) if params[:user]
    offers
  end
end
