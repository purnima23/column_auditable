require 'active_record'
require 'logger'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')
ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.column :name, :string
    t.column :username, :string
    t.column :created_at, :datetime
    t.column :updated_at, :datetime
  end
  
  create_table :column_audits, force: true do |t|
    t.column :auditable_id, :integer
    t.column :auditable_type, :string
    t.column :audited_name, :string
    t.column :audited_value, :string
    t.column :whodunnit, :string
    t.column :comment, :string
    t.column :created_at, :datetime
  end

  add_index :column_audits, [:auditable_id, :auditable_type], name: 'auditable_index'
  add_index :column_audits, [:audited_name, :audited_value], name: 'audited_index'
  add_index :column_audits, :created_at
end