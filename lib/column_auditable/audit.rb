module ColumnAuditable
  class Audit < ::ActiveRecord::Base
    self.table_name = 'column_audits'
    
    attr_accessible :audited_name, :audited_value, :comment, :whodunnit
    
    belongs_to :auditable, polymorphic: true
    
    scope :only_audited_name, ->(name){where(audited_name: name)}
    scope :only_audited_value, ->(value){where(audited_value: value)}
  end
end