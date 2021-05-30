# frozen_string_literal: true

class Api::V1::OrdersController < ApplicationController
  before_action :create_order

  def create
    render status: :not_found if order_params.blank?

    @builder = camel_case_payload.to_json

    if ProcessOrderService.call(@builder)
      render status: :accepted
    else
      render status: :not_found
    end
  end

  private

  def payload
    {
      external_code: order_params['id'].to_s,
      store_id: order_params['store_id'],
      sub_total: sub_total,
      delivery_fee: order_params['total_shipping'].to_s,
      total: order_params['total_amount_with_shipping'].to_s,
      dt_order_create: order_params['date_created'],
      postal_code: order_params['shipping']['receiver_address']['zip_code'],
      number: order_params['shipping']['receiver_address']['street_number'],
      total_shipping: total_shipping,
      address_attributes: address_block,
      customer_attributes: customer_block,
      items_attributes: items_block,
      payments_attributes: payments_block
    }
  rescue StandardError
    {}
  end

  def sub_total
    format('%<total>.2f', total: order_params['total_amount'])
  rescue StandardError
    0.0
  end

  def country
    order_params['shipping']['receiver_address']['country']['id']
  rescue StandardError
    'BR'
  end

  def state
    order_params['shipping']['receiver_address']['state']['id']
  end

  def city
    order_params['shipping']['receiver_address']['city']['name']
  end

  def district
    order_params['shipping']['receiver_address']['neighborhood']['name']
  end

  def street
    order_params['shipping']['receiver_address']['street_name']
  end

  def complement
    order_params['shipping']['receiver_address']['comment']
  end

  def latitude
    order_params['shipping']['receiver_address']['latitude']
  end

  def longitude
    order_params['shipping']['receiver_address']['longitude']
  end

  def create_order
    attributes = payload
    attributes[:items_attributes].map! { |hash| hash&.except!('sub_items') }

    @order = Order.create!(attributes)
  end

  def order_params
    params.permit!
  end

  def camel_case_payload
    payload.deep_transform_keys! do |key|
      if key == :total_shipping
        key.to_s.gsub('attributes', '')
      else
        key.to_s.gsub('attributes', '').camelize(:lower)
      end
    end
  end

  def address_block
    {
      'country' => country,
      'state' => state,
      'city' => city,
      'district' => district,
      'street' => street,
      'complement' => complement,
      'latitude' => latitude,
      'longitude' => longitude
    }
  rescue NoMethodError
    {}
  end

  def customer_block
    buyer = order_params['buyer']
    buyer_phone = order_params['buyer']['phone']

    {
      'external_code' => buyer['id'].to_s,
      'name' => buyer['nickname'].to_s,
      'email' => buyer['email'].to_s,
      'contact' => "#{buyer_phone['area_code']}#{buyer_phone['number']}"
    }
  rescue NoMethodError
    {}
  end

  def items_block
    order_params['order_items'].map do |item|
      {
        'external_code' => item['item']['id'],
        'name' => item['item']['title'],
        'price' => item['full_unit_price'],
        'quantity' => item['quantity'],
        'total' => item['unit_price'].to_f * item['quantity'].to_i,
        'sub_items' => []
      }
    end
  rescue NoMethodError
    []
  end

  def payments_block
    order_params['payments'].map do |payment|
      {
        'type' => payment['payment_type'].upcase,
        'value' => payment['total_paid_amount']
      }
    end
  rescue NoMethodError
    []
  end

  def total_shipping
    order_params['total_shipping'] || 0.0
  end
end
