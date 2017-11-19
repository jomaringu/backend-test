=begin
get    '(/user/:user_domain)(/u/:user_domain)/api/v1/tables/:table_id/records/:id'         => 'records#show',    as: :api_v1_tables_records_show,   constraints: { table_id: /[^\/]+/ }
post   '(/user/:user_domain)(/u/:user_domain)/api/v1/tables/:table_id/records'             => 'records#create',  as: :api_v1_tables_records_create, constraints: { table_id: /[^\/]+/ }
put    '(/user/:user_domain)(/u/:user_domain)/api/v1/tables/:table_id/records/:cartodb_id' => 'records#update',  as: :api_v1_tables_record_update,  constraints: { table_id: /[^\/]+/ }
delete '(/user/:user_domain)(/u/:user_domain)/api/v1/tables/:table_id/records/:cartodb_id' => 'records#destroy', as: :api_v1_tables_record_destroy, constraints: { table_id: /[^\/]+/ }
=end

class UserController < ApplicationController
  before_filter only: [:show, :update, :destroy]

  include ExceptionHandler
  include Response

  # Just for testing purpose
  def index
    @token = ActiveRecord::Base.connection.execute("select * from tokens where permission='"+params[:permission]+"' limit 1;").first;
    json_response(@token,:ok)
  end
    
  #get    '(/user/:user_domain)(/u/:user_domain)/api/v1/tables/:table_id/records/:id'         => 'records#show',    as: :api_v1_tables_records_show,   constraints: { table_id: /[^\/]+/ }
  def show
    checkPermissions(params, 'R')
  end

  #post   '(/user/:user_domain)(/u/:user_domain)/api/v1/tables/:table_id/records'             => 'records#create',  as: :api_v1_tables_records_create, constraints: { table_id: /[^\/]+/ }
  def create
    checkPermissions(params, 'RW')
  end

  #put    '(/user/:user_domain)(/u/:user_domain)/api/v1/tables/:table_id/records/:cartodb_id' => 'records#update',  as: :api_v1_tables_record_update,  constraints: { table_id: /[^\/]+/ }
  def update
    checkPermissions(params, 'RW')
  end

  # delete '(/user/:user_domain)(/u/:user_domain)/api/v1/tables/:table_id/records/:cartodb_id' => 'records#destroy', as: :api_v1_tables_record_destroy, constraints: { table_id: /[^\/]+/ }
  def destroy
    checkPermissions(params, 'RW')
  end

  def checkPermissions(params, required_permission)
    print '*****************************'
    print required_permission
    print '*****************************'
    
    t = Token.find(params[:user_token])
      
    granted = false
    if( t.permission == required_permission )
      granted = true
    end
    if( t.permission == 'RW' && required_permission == 'R')
      granted = true
    end
      
    if( t.table_id == params[:table_id] && granted )
      response = t
      print 'User ['+params[:id]+ '] has [' + required_permission + '] permissions to access table ['+ t.table_id + ']'
      status = :ok # 200
    else
      response = '{"message" : "User '+params[:id]+ ' has not ' + required_permission + ' permissions to access table '+ params[:table_id] + '"}'
      print response
      status = :forbidden # 403
    end

    print response
    json_response(response, status)
  end

  def todo_params
    # whitelist params
    params.permit(:title, :created_by)
  end

end
