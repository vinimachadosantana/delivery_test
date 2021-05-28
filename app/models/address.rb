# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :order

  validates :country,
            :state,
            :city,
            :district,
            :street,
            :latitude,
            :longitude, presence: true
end
