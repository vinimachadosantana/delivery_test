class RemoveAdressesFieldsFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :country, :string
    remove_column :orders, :state, :string
    remove_column :orders, :city, :string
    remove_column :orders, :district, :string
    remove_column :orders, :street, :string
    remove_column :orders, :complement, :string
    remove_column :orders, :latitude, :float
    remove_column :orders, :longitude, :float
  end
end
