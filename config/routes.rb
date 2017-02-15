Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

require 'sidekiq/web'
mount Sidekiq::Web => '/sidekiq'

post '/details/new', to: 'check#new'
get '/', to: 'check#index'
get '/show', to: 'check#show'
get '/details/:id', to: 'check#check'
put '/details/:id', to: 'check#update'
delete '/:id', to: 'check#delete'
get '/:id/delete' , to: 'check#deletion_details'
end
