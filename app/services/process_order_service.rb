# frozen_string_literal: true

class ProcessOrderService < BaseService
  URL = URI(ENV["API_URL"]).freeze

  def initialize(get_token: GenerateTokenService)
    @get_token = get_token.call
  end

  def call(payload)
    response = connection.request(request(payload))

    response.code == "200"
  end

  private

  def request(body)
    req = Net::HTTP::Post.new(URL.path)
    req["Content-Type"] = "application/json"
    req["X-Sent"] = Time.zone.now.strftime("%Hh%M - %d/%m/%y")
    req["Authorization"] = @get_token
    req.body = body
    req
  end

  def connection
    http = Net::HTTP.new(URL.host, URL.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http
  end
end
