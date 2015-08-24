Rails.application.routes.draw do
  concern :geo do
    resources :countries, only: [:index] do
      resources :cities, only: [:index]
      resources :regions, only: [:index] do
        resources :cities, only: [:index]
        resources :districts, only: [:index] do
          resources :cities, only: [:index]
        end
      end
    end
  end

  namespace :geo do
    concerns :geo
    resources :continents, only: [:index], concerns: :geo do
      get :all, on: :collection
    end
  end

end
