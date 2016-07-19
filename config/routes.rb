Rails.application.routes.draw do
  root to: 'index#index'

  get '/slides/:demo_name/', to: 'slides#index'

  namespace :mobile do
    get '/learning-center', to: 'learning_center#index'
    get '/learning-center/progress', to: 'learning_center#progress'
    get '/learning-center/messages', to: 'learning_center#messages'
    # get '/learning-center/login', to: 'learning_center#login'
  end
end
