class OffersController < ApplicationController
  def index
    @offers = OfferApi.load_offers((params[:offer] || {}).symbolize_keys)
  end
end
