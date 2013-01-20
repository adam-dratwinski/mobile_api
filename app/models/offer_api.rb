class OfferApi
  def initialize(params = {})
    @params         = params
    @request_params = params.reverse_merge(OfferApi.config)
    @request_params.delete :api_key
  end

  def load_offers
    return [] if @params.empty?
    request["offers"].map(&:symbolize_keys).map do |offer|
      Offer.new(offer)
    end
  end

  def self.load_offers(params)
    OfferApi.new(params).load_offers
  end

  def self.config
    config_hash = YAML.load(File.open(File.expand_path('../../../config/offer_api.yml',  __FILE__)))
    config_hash["offer_api"].symbolize_keys
  end

  private

  def request
    response = HTTParty.get(request_url)
    validate(response)
    response
  end

  def validate(response)
    unless check_response(response)
      raise OfferApi::BadSignatureException
    end
  end

  def check_response(response)
    response.headers["x-sponsorpay-response-signature"] == Digest::SHA1.hexdigest(response.body + OfferApi.config[:api_key])
  end

  def request_url
    OfferApi::Params.new(@request_params, OfferApi.config[:api_key]).generate_api_url
  end

  class BadSignatureException < Exception; end
end
