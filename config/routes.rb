BackendTest::Application.routes.draw do
  root :to => 'home#index'
  
  get 'tokens/', to: 'user#index'
  
  get 'user/:id/api/v1/tables/:table_id/records/:cartodb_id', to: 'user#show'
  get 'u/:id/api/v1/tables/:table_id/records/:cartodb_id', to: 'user#show'
  
  post 'user/:id/api/v1/tables/:table_id/records', to: 'user#create' 
  post 'u/:id/api/v1/tables/:table_id/records', to: 'user#create'
  
  put 'user/:id/api/v1/tables/:table_id/records/:cartodb_id', to: 'user#update' 
  put 'u/:id/api/v1/tables/:table_id/records/:cartodb_id', to: 'user#update'
  
  delete 'user/:id/api/v1/tables/:table_id/records/:cartodb_id', to: 'user#destroy' 
  delete 'u/:id/api/v1/tables/:table_id/records/:cartodb_id', to: 'user#destroy'
  
end
