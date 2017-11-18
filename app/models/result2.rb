=begin
Backend, Charles, 1233303
Engine, Bob, 1225498
Frontend, Daphne, 1279748
Leads, Alice, 1249250
Leads, Bob, 1225498
Madrid, Daphne, 1279748
Madrid, Alice, 1249250
Madrid, Charles, 1233303
Madrid, Bob, 1225498
Product, Alice, 1249250
Product, Charles, 1233303
=end

class Result2 
  attr_accessor :group_name, :user_name, :groups_count
   
  def initialize(result)
    @group_name = result['group_name']
    @user_name = result['user_name']
    @groups_count = result['groups_count']
  end
  
end
