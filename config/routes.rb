Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end


# config/routes.rb con soap per la tabella postgresql users
Rails.application.routes.draw do
  # Rotta per il servizio SOAP, possiamo definire una rotta principale che si collega a tutte le operazioni del controller
  post 'users_service', to: 'users_soap#users_service' 
  # Rotta per il WSDL
  get 'users_service.wsdl', to: 'users_soap#wsdl'  #Definisce le operazioni disponibili
end



# config/routes.rb con rest e soap per la collezione mongo
# config/routes.rb
Rails.application.routes.draw do
  # Rotta per GraphQL
  post '/graphql', to: 'graphql#execute'

  resources :comments, only: [:create, :update, :destroy] do
    collection do
      get 'order', to: 'comments#order'
    end
  end
end

# config/routes.rb con rethinkdb e websocket
Rails.application.routes.draw do
  mount ActionCable.server => '/cable' # WebSocket
  resources :simulation_streaming, only: [:create, :update, :destroy] do
    collection do
      get :stream_simulations
    end
  end
end

# config/routes.rb con influxdb
Rails.application.routes.draw do
  resources :performance_monitorings, only: [ :create, :update, :destroy]
  # Route per GraphQL
  post '/graphql', to: 'graphql#execute'
end

# config/routes.rb per ArangoDB
Rails.application.routes.draw do
  # Rotte REST per RelazioneCelle
  namespace :rest do
    resources :relazione_celle, only: [:create, :update, :destroy]
  end
  # Rotta per le richieste GraphQL
  post '/graphql', to: 'graphql#execute'
end



