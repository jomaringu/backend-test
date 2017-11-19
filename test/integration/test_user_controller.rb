require 'minitest/autorun'
require 'rest_client'
require 'json'

class UserControllerTest < MiniTest::Unit::TestCase
  def setup
    response = RestClient.get("http://localhost:3000/tokens/?permission=R",
    {
      "Content-Type" => "application/json"
    }
    )
    @tokenR = JSON.parse response.body
    assert @tokenR  != nil

    response = RestClient.get("http://localhost:3000/tokens/?permission=RW",
    {
      "Content-Type" => "application/json"
    }
    )
    @tokenRW = JSON.parse response.body
    assert @tokenRW != nil
  end

  # GET
  def test_get_user_token_not_found
    begin
      response = RestClient.get("http://localhost:3000/u/whatEver/api/v1/tables/whatEver/records/whatEver?user_token=abcd",
      {
        "Content-Type" => "application/json"
      }
      )
    rescue => e
      assert_equal "404 Not Found", e.message
    end
  end

  def test_get_user_token_not_allowed
    user_token = @tokenR['value']
    begin
      response = RestClient.get("http://localhost:3000/u/whatEver/api/v1/tables/whatEver/records/whatEver?user_token="+user_token,
      {
        "Content-Type" => "application/json"
      }
      )
    rescue => e
      assert_equal "403 Forbidden", e.message
    end
  end

  def test_get_correct_same_permission
    user_token = @tokenR['value']
    table_id = @tokenR['table_id']

    response = RestClient.get("http://localhost:3000/u/3/api/v1/tables/"+table_id+"/records/2?user_token="+user_token,
    {
      "Content-Type" => "application/json"
    }
    )
    @data = JSON.parse response.body
    assert_equal user_token, @data['value']
  end

  def test_get_correct_wider_permission
    user_token = @tokenRW['value']
    table_id = @tokenR['table_id']

    response = RestClient.get("http://localhost:3000/u/3/api/v1/tables/"+table_id+"/records/2?user_token="+user_token,
    {
      "Content-Type" => "application/json"
    }
    )
    @data = JSON.parse response.body
    assert_equal user_token, @data['value']

    response = RestClient.get("http://localhost:3000/user/3/api/v1/tables/"+table_id+"/records/2?user_token="+user_token,
    {
      "Content-Type" => "application/json"
    }
    )
    @data = JSON.parse response.body
    assert_equal user_token, @data['value']
  end

  # POST
  #post   '(/user/:user_domain)(/u/:user_domain)/api/v1/tables/:table_id/records'             => 'records#create',  as: :api_v1_tables_records_create, constraints: { table_id: /[^\/]+/ }
  def test_post_user_token_not_found
    begin
      response = RestClient.post("http://localhost:3000/u/whatEver/api/v1/tables/whatEver/records/?user_token=abcd",
      {
        "Content-Type" => "application/json"
      }
      )
    rescue => e
      assert_equal "404 Not Found", e.message
    end
  end

  def test_post_user_token_not_allowed
    user_token = @tokenR['value']
    table_id = @tokenR['table_id']
    begin
      response = RestClient.post("http://localhost:3000/u/whatEver/api/v1/tables/"+table_id+"/records/?user_token="+user_token,
      {
        "Content-Type" => "application/json"
      }
      )
    rescue => e
      assert_equal "403 Forbidden", e.message
    end
  end

  def test_post_correct_same_permission
    user_token = @tokenRW['value']
    table_id = @tokenRW['table_id']

    response = RestClient.post("http://localhost:3000/u/3/api/v1/tables/"+table_id+"/records/?user_token="+user_token,
    {
      "Content-Type" => "application/json"
    }
    )
    @data = JSON.parse response.body
    assert_equal user_token, @data['value']
  end

  #PUT
  #put    '(/user/:user_domain)(/u/:user_domain)/api/v1/tables/:table_id/records/:cartodb_id' => 'records#update',  as: :api_v1_tables_record_update,  constraints: { table_id: /[^\/]+/ }
  def test_put_user_token_not_found
    begin
      response = RestClient.put("http://localhost:3000/u/whatEver/api/v1/tables/whatEver/records/whatEver?user_token=abcd",
      {
        "Content-Type" => "application/json"
      }
      )
    rescue => e
      assert_equal "404 Not Found", e.message
    end
    begin
      response = RestClient.put("http://localhost:3000/user/whatEver/api/v1/tables/whatEver/records/whatEver?user_token=abcd",
      {
        "Content-Type" => "application/json"
      }
      )
    rescue => e
      assert_equal "404 Not Found", e.message
    end
  end

  def test_put_user_token_not_allowed
    user_token = @tokenR['value']
    table_id = @tokenR['table_id']
    begin
      response = RestClient.put("http://localhost:3000/u/whatEver/api/v1/tables/"+table_id+"/records/whatEver?user_token="+user_token,
      {
        "Content-Type" => "application/json"
      }
      )
    rescue => e
      assert_equal "403 Forbidden", e.message
    end
  end

  def test_put_correct_same_permission
    user_token = @tokenRW['value']
    table_id = @tokenRW['table_id']

    response = RestClient.put("http://localhost:3000/u/3/api/v1/tables/"+table_id+"/records/whatEver?user_token="+user_token,
    {
      "Content-Type" => "application/json"
    }
    )
    @data = JSON.parse response.body
    assert_equal user_token, @data['value']
  end

  #DELETE
  # delete '(/user/:user_domain)(/u/:user_domain)/api/v1/tables/:table_id/records/:cartodb_id' => 'records#destroy', as: :api_v1_tables_record_destroy, constraints: { table_id: /[^\/]+/ }
  def test_delete_user_token_not_found
    begin
      response = RestClient.delete("http://localhost:3000/u/whatEver/api/v1/tables/whatEver/records/whatEver?user_token=abcd",
      {
        "Content-Type" => "application/json"
      }
      )
    rescue => e
      assert_equal "404 Not Found", e.message
    end
    begin
      response = RestClient.delete("http://localhost:3000/user/whatEver/api/v1/tables/whatEver/records/whatEver?user_token=abcd",
      {
        "Content-Type" => "application/json"
      }
      )
    rescue => e
      assert_equal "404 Not Found", e.message
    end
  end

  def test_delete_user_token_not_allowed
    user_token = @tokenR['value']
    table_id = @tokenR['table_id']
    begin
      response = RestClient.delete("http://localhost:3000/u/whatEver/api/v1/tables/"+table_id+"/records/whatEver?user_token="+user_token,
      {
        "Content-Type" => "application/json"
      }
      )
    rescue => e
      assert_equal "403 Forbidden", e.message
    end
  end

  def test_delete_correct_same_permission
    user_token = @tokenRW['value']
    table_id = @tokenRW['table_id']

    response = RestClient.delete("http://localhost:3000/u/3/api/v1/tables/"+table_id+"/records/whatEver?user_token="+user_token,
    {
      "Content-Type" => "application/json"
    }
    )
    @data = JSON.parse response.body
    assert_equal user_token, @data['value']

    response = RestClient.delete("http://localhost:3000/user/3/api/v1/tables/"+table_id+"/records/whatEver?user_token="+user_token,
    {
      "Content-Type" => "application/json"
    }
    )
    @data = JSON.parse response.body
    assert_equal user_token, @data['value']
  end

end

