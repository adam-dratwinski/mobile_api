class OffersController < ApplicationController
  def index
    @offers = []
    @offers << Offer.new(:title => "Offer Title", :payout => "Offer Payout", :thumbnail => "Offer thumbnail") if params[:user]
  end
end
