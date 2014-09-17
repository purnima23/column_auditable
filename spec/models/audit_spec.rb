require 'spec_helper'

describe ColumnAuditable::Audit do
  let!(:user) {Models::User.create(name: 'soh cher wei', username: 'cherwei')}
  let!(:user_2) {Models::User.create(name: 'soh cher wei 2', username: 'cherwei')}
  
  describe '#only_audited_name' do
    it 'should return records scope by audited_name' do
      user.update_attribute(:username, 'something else')
      ColumnAuditable::Audit.only_audited_name(:username).count.should eq(3)
    end
    
    it 'should return associated records scope by audited_name' do
      user.audits.only_audited_name(:username).count.should eq(1)
    end
  end
  
  describe '#only_audited_value' do
    it 'should return records scope by audited_value' do
      user.update_attribute(:username, 'something else')
      ColumnAuditable::Audit.only_audited_value('cherwei').count.should eq(2)
    end
    
    it 'should return associated records scope by audited_value' do
      user.update_attribute(:username, 'something else')
      user.audits.only_audited_value('cherwei').count.should eq(1)
    end
  end
end