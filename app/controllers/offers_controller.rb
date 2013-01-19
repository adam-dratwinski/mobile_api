class OffersController < ApplicationController
  def index
    @offers = Offer.find((params[:offer] || {}).symbolize_keys)
  end
end
