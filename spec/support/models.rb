require 'cgi'
require File.expand_path('../schema', __FILE__)

module Models
  class User < ::ActiveRecord::Base
    attr_accessible :name, :username
    
    audited audited_name: :username
  end
end