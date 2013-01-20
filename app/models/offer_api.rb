require 'digest/sha1'

class OfferApi
  def self.config
    config_hash = YAML.load(File.open(File.expand_path('../../../config/offer_api.yml',  __FILE__)))
    config_hash["offer_api"].symbolize_keys
  end

  def self.generate_hash params_array, api_key
    params = params_array.sort 
    params = params.map { |pair| "#{pair[0]}=#{pair[1]}" }
    params = params.join("&")
    params = params + "&#{api_key}"
    params = Digest::SHA1.hexdigest(params)

    params
  end

  def self.generate_api_url params, api_key
    params[:timestamp] = Time.now.to_i
    params[:hashkey]   = self.generate_hash(params, api_key)
    params = params.map { |pair| "#{pair[0]}=#{pair[1]}" }
    params = params.join("&")
    
    "http://api.sponsorpay.com/feed/v1/offers.json?#{params}"
  end

  def self.load params
    params = config.merge(params)
    HTTParty.get OfferApi.generate_api_url(params, config[:api_key])
  end

  def self.load_offers params = {}
    return [] if params.empty?
    OfferApi.load(params)["offers"].map(&:symbolize_keys).map do |offer|
      Offer.new(offer)
    end
  end
end
