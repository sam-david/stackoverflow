Rails.application.routes.draw do

  resources :questions do
    member do
      put 'upvote'
      put 'downvote'
    end
    resources :answers do
      put 'upvote'
      put 'downvote'
    end
  end

  # root 'welcome#index'
  root 'questions#index'
end
