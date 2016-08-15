Rails.application.routes.draw do
  root to: 'index#index'

  get '/slides/:demo_name/', to: 'slides#index'

  namespace :mobile do
    get '/learning-center',          to: 'learning_center#index'
    get '/learning-center/progress', to: 'learning_center#progress'

    get '/learning-center/subjects',            to: 'learning_center#subjects'
    get '/learning-center/subjects/outline',    to: 'learning_center#subjects_outline'
    get '/learning-center/subjects/outline/video', to: 'learning_center#subjects_outline_video'
    get '/learning-center/subjects/outline/ppt', to: 'learning_center#subjects_outline_ppt'
    get '/learning-center/subjects/posts',      to: 'learning_center#subjects_posts'
    get '/learning-center/subjects/posts/all',  to: 'learning_center#subjects_posts_all'
    get '/learning-center/subjects/target',     to: 'learning_center#subjects_target'
    post '/learning-center/target-search',      to: 'learning_center#target_search'

    get '/learning-center/messages', to: 'learning_center#messages'
    get '/learning-center/messages/:channel', to: 'learning_center#messages_channel'

    get '/learning-center/plan',     to: 'learning_center#plan'
    get '/learning-center/plan/:id', to: 'learning_center#plan_id'

    get '/learning-center/subjects/target/solve', to: 'learning_center#solve'

    get '/learning-center/todo', to: 'learning_center#todo'
    # get '/learning-center/login', to: 'learning_center#login'
  end
end
