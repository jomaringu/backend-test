=begin
id | token_value | table_id | permission
=end
class Record < ActiveRecord::Base
  attr_accessible :value, :table_id, :permission
  
end
