class OfferApi
  class Params
    def initialize(params, api_key)
      @params  = params.reverse_merge :timestamp => Time.now.to_i
      @api_key = api_key
    end

    def generate_hash 
      params = @params.sort 
      params = convert_array_to_string(params)
      params = params + "&#{@api_key}"

      Digest::SHA1.hexdigest(params)
    end

    def generate_api_url 
      params = @params.merge :hashkey => generate_hash 
      params = convert_array_to_string(params)
      
      "http://api.sponsorpay.com/feed/v1/offers.json?#{params}"
    end

    private

    def convert_array_to_string(params)
      params = params.map { |pair| "#{pair[0]}=#{pair[1]}" }

      params.join("&")
    end
  end
end
