Rails.application.routes.draw do
  get "care_logs/index"
  get "achievements/index"
  get "profiles/show"
  devise_for :users
  get  "/plant",        to: "plants#show",      as: :plant
  post "/plant/water",  to: "plants#water",     as: :water_plant
  post "/plant/quest",  to: "plants#do_quest",  as: :quest_plant
  post "/plant/quest/answer", to: "plants#submit_quest_response", as: :submit_quest_response

  resource :plant, only: [:show, :new, :create, :edit, :update]
  resource :profile, only: [:show]
  get 'mon_profil', to: 'users#profile', as: 'mon_profil'
  get "achievements", to: "achievements#index", as: :achievements
  get "/historique", to: "care_logs#index", as: :care_logs
  resources :care_logs, only: [:index]

  get "quiz/start", to: "quiz#start", as: :quiz_start
  get "quiz/show", to: "quiz#show", as: :quiz_show
  post "quiz/answer", to: "quiz#answer", as: :quiz_answer
  get "quiz/result", to: "quiz#result", as: :quiz_result


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
