class HomeController < ApplicationController
  def index

    exercise1()
    exercise2()
    exercise3()

    respond_to do |format|
      format.html # index.html.erb
      format.xml # { render :xml => @results1 }
    end
  end

  #######################################################################################################
  # Exercise 1 method
  # I have built just one SQL script to query the data base with all required data avoiding multiple
  # queries and filter later. It is the most efficient way to get the requested data as far as I know.
  # Once the data is returned by the database, I populate an array of DTO's Result1 (sorry by the name)
  # which will be injected into the front end view.
  #######################################################################################################
  
  def exercise1
    @content = ActiveRecord::Base.connection.execute("
                            SELECT
                                u.name as user_name,
                                COUNT(gr.name) as groups_count,
                                CONCAT('[', COALESCE(STRING_AGG(gr.name, ', ' ), ''),']') as groups
                            FROM ((users as u
                                LEFT JOIN groups_users as gu ON u.id=gu.user_id)
                                LEFT JOIN groups as gr ON gr.id = gu.group_id)
                            GROUP BY user_name
                            ORDER BY groups_count;");

    @results1 = []

    index = 0
    @content.each do |r|
      @results1[index] = Result1.new r
      index = index + 1;
    end

    return @results1
  end

  #######################################################################################################
  # Exercise 2 method
  # I have built just one SQL script to query the data base with all required data avoiding multiple
  # queries and filter later. It is the most efficient way to get the requested data as far as I know.
  # Once the data is returned by the database, I populate an array of DTO's Result2 (sorry by the name)
  # which will be injected into the front end view.
  #######################################################################################################
  def exercise2
    @content = ActiveRecord::Base.connection.execute("
                            SELECT
                                gr.name as group_name,
                                u.name as user_name,
                                sum(m.mapviews) as groups_count
                            FROM (((users as u
                                INNER JOIN groups_users as gu ON u.id=gu.user_id)
                                INNER JOIN groups as gr ON gr.id = gu.group_id)
                                INNER JOIN maps as m ON m.user_id = u.id)
                            GROUP BY (gr.name, u.name)
                            ORDER BY gr.name, groups_count DESC;");

    @results2 = []

    index = 0
    @content.each do |r|
      @results2[index] = Result2.new r
      index = index + 1;
    end

    return @results2
  end

  #######################################################################################################
  # Exercise 3 method
  # I have built just one SQL script to query the data base with all required data avoiding multiple
  # queries and filter later. It is the most efficient way to get the requested data as far as I know.
  # Once the data is returned by the database, I populate an array of DTO's Result3 (sorry by the name)
  # which will be injected into the front end view.
  #######################################################################################################
  def exercise3
    @content = ActiveRecord::Base.connection.execute("
                            SELECT
                                gr.name as group,
                                u.name as name,
                                SUM(m.mapviews) as views,
                                CONCAT(CAST(ROUND((SUM(m.mapviews)*100)/SUM(SUM(m.mapviews)) OVER (PARTITION BY gr.name),2) as text), '%') as percent_of_group_views
                            FROM (((users as u
                                INNER JOIN groups_users as gu ON u.id=gu.user_id)
                                INNER JOIN groups as gr ON gr.id = gu.group_id)
                                INNER JOIN maps as m ON m.user_id = u.id)
                            GROUP BY (gr.name, u.name)
                            ORDER BY gr.name ASC, percent_of_group_views DESC;");

    @results3 = []

    index = 0
    @content.each do |r|
      @results3[index] = Result3.new r
      index = index + 1;
    end

    return @results3
  end

end
