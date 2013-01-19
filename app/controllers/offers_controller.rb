class OffersController < ApplicationController
  def index
    @offers = Offer.find(params)
  end
end
