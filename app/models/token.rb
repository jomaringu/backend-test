class Token < ActiveRecord::Base
  self.primary_key = 'value'
  attr_accessible :table_id, :permission
end
