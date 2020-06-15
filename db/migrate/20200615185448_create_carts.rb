class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.jsonb :state, default: '{}'
      t.text :access_token, null: false, index: true
      t.references(:store, foreign_key: true, null: false, index: true)
      t.timestamps
    end
  end
end
