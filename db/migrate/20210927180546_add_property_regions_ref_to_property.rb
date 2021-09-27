class AddPropertyRegionsRefToProperty < ActiveRecord::Migration[6.1]
  def change
    add_reference :properties, :property_region, null: false, foreign_key: true
  end
end
