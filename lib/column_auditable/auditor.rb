module ColumnAuditable
  module Auditor
    extend ActiveSupport::Concern
    
    included do
    end
    
    module ClassMethods
      def audited(options={})
        cattr_accessor :audited_name
        attr_accessor :audit_comment, :audit_whodunnit
        
        raise ArguementError.new("Please define audited_name") unless options[:audited_name]
        self.audited_name = options[:audited_name]
      
        has_many :audits, as: :auditable, class_name: "ColumnAuditable::Audit"
      
        after_create :audit_create, unless: Proc.new{|a| a.send("#{a.audited_name}").blank?}
        before_update :audit_update, if: Proc.new{|a| a.send("#{a.audited_name}_changed?") && !a.send("#{a.audited_name}").blank?}
        
        include ColumnAuditable::Auditor::AuditedInstanceMethods
      end
    end
    
    module AuditedInstanceMethods
      private
      def audit_create
        write_audit(audited_name: self.audited_name, audited_value: self.send(audited_name), comment: audit_comment, whodunnit: audit_whodunnit)
      end
      
      def audit_update
        write_audit(audited_name: self.audited_name, audited_value: self.send(audited_name), comment: audit_comment, whodunnit: audit_whodunnit)
      end
      
      def write_audit(attrs)
        self.audit_comment = self.audit_whodunnit = nil
        self.audits.create(attrs)
      end
    end
  end
end

ActiveRecord::Base.send :include, ColumnAuditable::Auditor