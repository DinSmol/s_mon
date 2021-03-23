class Init < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'uuid-ossp'
    create_table(:objects, { id: false }) do |t|
      t.uuid :id, primary_key: true, default: 'uuid_generate_v4()'
      t.string :address, unique: true
      t.string :description
      t.column :created_at, 'timestamp with time zone', default: 'now()'
      t.column :updated_at, 'timestamp with time zone', default: 'now()'
      t.uuid :created_by
      t.uuid :updated_by
      t.boolean :disabled, default: false, null: false
    end
  end
end
