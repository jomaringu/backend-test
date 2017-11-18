=begin
Eva - 20VD6w7LkMKOA - 0 - []
Daphne - 20Rz52sSo/wpo - 2 - ["Frontend", "Madrid"]
Charles - 20sn5SsIlkS8E - 3 - ["Product", "Backend", "Madrid"]
Bob - 20H3bGo1QH5VQ - 3 - ["Leads", "Engine", "Madrid"]
Alice - 20EPxrR6s1g7I - 3 - ["Product", "Leads", "Madrid"]
=end

class Result1 
  attr_accessor :name, :groups_count, :crypted_name, :groups
   
  def initialize(result)
    @name = result['user_name']
    @groups_count = result['groups_count']
    @groups = result['groups']
  end
     
  def crypted_name
    name.crypt('salt')
  end
  

end
