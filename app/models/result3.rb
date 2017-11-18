=begin
group   |  name   |  views  | percent_of_group_views
----------+---------+---------+-----------------------
Backend  | Charles | 1211037 | 100.00% 
Engine   | Bob     | 1223563 | 100.00%
Frontend | Daphne  | 1264795 | 100.00%
Leads    | Alice   | 1251522 | 50.56%
Leads    | Bob     | 1223563 | 49.44%
Madrid   | Daphne  | 1264795 | 25.55%
Madrid   | Alice   | 1251522 | 25.28%
Madrid   | Bob     | 1223563 | 24.71%
Madrid   | Charles | 1211037 | 24.46%
Product  | Alice   | 1251522 | 50.82%
Product  | Charles | 1211037 | 49.18%
=end

class Result3 
  attr_accessor :group, :name, :views, :percent_of_group_views
   
  def initialize(result)
    @group = result['group']
    @name = result['name']
    @views = result['views']
    @percent_of_group_views = result['percent_of_group_views']
  end
  
end
