# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:customer) }
    it { is_expected.to have_one(:address) }
    it { is_expected.to have_many(:items) }
    it { is_expected.to have_many(:payments) }

    it { is_expected.to accept_nested_attributes_for(:customer) }
    it { is_expected.to accept_nested_attributes_for(:address) }
    it { is_expected.to accept_nested_attributes_for(:items) }
    it { is_expected.to accept_nested_attributes_for(:payments) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:external_code) }
    it { is_expected.to validate_presence_of(:store_id) }
    it { is_expected.to validate_presence_of(:sub_total) }
    it { is_expected.to validate_presence_of(:delivery_fee) }
    it { is_expected.to validate_presence_of(:total) }
    it { is_expected.to validate_presence_of(:dt_order_create) }
    it { is_expected.to validate_presence_of(:postal_code) }
    it { is_expected.to validate_presence_of(:number) }
  end
end
