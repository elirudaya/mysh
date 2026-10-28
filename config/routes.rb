Rails.application.routes.draw do
  get "admin", to: "admin#index", as: :admin
  get "admin/users", to: "admin#users", as: :admin_users
  get "admin/posts", to: "admin#posts", as: :admin_posts
  get "admin/emails", to: "admin#emails", as: :admin_emails

  get "home/index"
  get "welcome/index"

  resources :posts do
    collection do
      get :mine
    end

    resources :comments, only: [ :create, :edit, :update, :destroy ]
  end

  resources :profiles, only: [ :show, :edit, :update ]

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  post "emails", to: "welcome#create", as: :emails
  get "home", to: "home#index", as: :home
  root "welcome#index"

  scope "/admin", as: "admin" do
    resources :events
  end
end
