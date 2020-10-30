class CreateIdentities < ActiveRecord::Migration[6.0]
  def change
    create_table :identities do |t|
      t.string :authority, null: false
      t.string :identifier, null: false
      t.index [:authority, :identifier], unique: true

      t.jsonb :omniauth_info, null: true

      t.timestamps
    end
  end
end
