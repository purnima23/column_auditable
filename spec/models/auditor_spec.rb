require 'spec_helper'

describe ColumnAuditable::Auditor do
  let(:user) {Models::User.create(name: 'soh cher wei', username: 'cherwei')}
  
  describe 'auditable create' do
    it "should create new audit" do
      expect do
        user
      end.to change(ColumnAuditable::Audit, :count).by(1)
      
      audit = ColumnAuditable::Audit.last
      audit.auditable.should eq(user)
      audit.audited_name.should eq('username')
      audit.audited_value.should eq('cherwei')
    end
    
    it "should not create new audit if audited_value is empty" do
      user = Models::User.new(name: 'soh cher wei')
      expect do
        user.save
      end.not_to change(ColumnAuditable::Audit, :count)
    end
  end
  
  describe 'auditable update' do
    it "should create new audit" do
      user.username = 'new cherwei'
      expect do
        user.save
      end.to change(ColumnAuditable::Audit, :count).by(1)
      
      audit = ColumnAuditable::Audit.last
      audit.auditable.should eq(user)
      audit.audited_name.should eq('username')
      audit.audited_value.should eq('new cherwei')
    end
    
    it "should accept audit_comment" do
      comment = "test logging comment"
      user.username = 'new cherwei'
      user.audit_comment = comment
      expect do
        user.save
      end.to change(ColumnAuditable::Audit, :count).by(1)
      
      audit = ColumnAuditable::Audit.last
      audit.comment.should eq(comment)
    end
    
    it "should accept whodunnit" do
      user.username = 'new cherwei'
      user.audit_whodunnit = 'changer'
      expect do
        user.save
      end.to change(ColumnAuditable::Audit, :count).by(1)
      
      audit = ColumnAuditable::Audit.last
      audit.whodunnit.should eq('changer')
    end
    
    it "should not create new audit if audited_value not changed" do
      user.name = 'cherwei' # changed
      user.username = 'cherwei' # not changed
      expect do
        user.save
      end.not_to change(ColumnAuditable::Audit, :count)
    end
    
    it "should create cleared comment when audit is blank" do
      comment = "clear comment"
      user.username  = ''
      user.audit_comment = comment
      expect do 
        user.save
      end.to change(ColumnAuditable::Audit, :count).by(1)
      
      audit = ColumnAuditable::Audit.last
      audit.comment.should eq("CLEARED")
    end
  end

end