Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/parking-doc'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :parking do
    put "pay", to: "parking#pay"
    put "out", to: "parking#out"
  end
end
