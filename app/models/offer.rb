class Offer
  attr_accessor :title, :payout, :thumbnail

  def initialize params = {}
    @title     = params[:title]
    @payout    = params[:payout]
    @thumbnail = params[:thumbnail]
  end
end
