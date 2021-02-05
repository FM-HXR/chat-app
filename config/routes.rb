Rails.application.routes.draw do
  
  devise_for :users
  
  root to: "rooms#index"
  
  resources :users, only: [:edit, :update]
  resources :rooms do
    resources :messages  
  end
  
end

# Rails.application.routes.draw do
#   devise_for :users
#   root to: "tweets#index"
#   resources :tweets do
#     resources :comments, only: :create
#     collection do
#       get 'search'
#     end
#   end  
#   resources :users, only: :show
# end
