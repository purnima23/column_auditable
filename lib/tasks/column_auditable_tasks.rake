namespace :column_auditable do
  desc "This task is to populate column_audits records for specify model"
  task :populate_for => :environment do
    raise NameError.new("You need to specify object class as 'model'") unless ENV['model']
    
    klass = ENV['model'].capitalize.constantize
    
    klass.find_each do |obj|
      attrs = {
        audited_name: klass.audited_name, 
        audited_value: obj.send(klass.audited_name)
      }
      audit = obj.audits.new(attrs)
      audit.created_at = obj.updated_at
      audit.save
    end
  end
end