# frozen_string_literal: true

class GenerateTokenService < BaseService
  TOKEN_URL = URI(ENV['API_URL_TOKEN']).freeze

  def call
    JSON.parse(request.body)['token'].chomp
  end

  private

  def request
    connection.request(get)
  end

  def connection
    http = Net::HTTP.new(TOKEN_URL.host, TOKEN_URL.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http
  end

  def get
    Net::HTTP::Get.new(TOKEN_URL.request_uri)
  end
end
