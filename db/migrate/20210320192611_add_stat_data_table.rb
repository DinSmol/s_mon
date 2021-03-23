class AddStatDataTable < ActiveRecord::Migration[6.1]
  def change
    create_table(:stat_data, { id: false }) do |t|
      t.uuid :id, primary_key: true, default: 'uuid_generate_v4()'
      t.string :address
      t.float :min
      t.float :avg
      t.float :max
      t.float :mdev
      t.float :loss
      t.column :created_at, 'timestamp with time zone', default: Time.now
      t.column :updated_at, 'timestamp with time zone', default: Time.now
    end
  end
end
