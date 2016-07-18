Rails.application.routes.draw do
  root to: 'index#index'

  get '/:demo_name/', to: 'slides#index'
end
