Rails.application.routes.draw do
  
  devise_for :users
  
  root to: "rooms#index"
  
  resources :users, only: [:edit, :update]
  # when routing to messages controller & page, it does so by passing through rooms routing.
  # therefore, e.g. messages#index routing is /rooms/:room_id/messages(.:format) 
  # this structure anchors on the fact that the room must be identified beforehand to do anything with messages.
  resources :rooms do
    resources :messages do
      collection do
        get 'search'
      end
    end
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
