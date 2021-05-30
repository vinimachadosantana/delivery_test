# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from StandardError do |_error|
    render status: :not_found
  end
end
