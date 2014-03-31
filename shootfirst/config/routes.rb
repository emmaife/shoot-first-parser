Shootfirst::Application.routes.draw do


  devise_for :users

  resources :shoot_first, :controller => 'combat_parsers', :as => 'combat_parsers'

  root 'combat_parsers#index'

  get 'shoot_first/:id/breakdown' => 'combat_parsers#breakdown'

end
