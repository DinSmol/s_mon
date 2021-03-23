class AddActivePeriodsTable < ActiveRecord::Migration[6.1]
  def change
    create_table(:active_periods, { id: false }) do |t|
      t.uuid :id, primary_key: true, default: 'uuid_generate_v4()'
      t.string :address, unique: true
      t.column :started_at, 'timestamp with time zone', index: true, default: Time.now
      t.column :stopped_at, 'timestamp with time zone', index: true
      t.column :created_at, 'timestamp with time zone', default: Time.now
      t.column :updated_at, 'timestamp with time zone', default: Time.now
    end
  end
end
