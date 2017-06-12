Rails.application.routes.draw do
  # devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)
  resources :collect_images
  resources :collections
  # resources :registrations
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, :as => ''
  end

  devise_for(
    :users,
    controllers: {
      omniauth_callbacks: "omniauth_callbacks"
    }
  )
  namespace :api do
    namespace :users do
      get 'student_details', to: 'students#student_details', as:'student_details'
      get 'faculty_details', to: 'faculties#faculty_details', as:'faculty_details'
    end
  end
  resources :apply_jobs, :concerns => :paginatable do
    put 'approved', to: 'apply_jobs#approved', as: 'approved'
    put 'reject_application', to: 'apply_jobs#reject_application', as: 'reject_application'
    get 'confirmation', to: "apply_jobs#confirmation", as: 'confirmation'
  end
  resources :apply_admissions, :concerns => :paginatable do
    put 'approved', to: 'apply_admissions#approved', as: 'approved'
    put 'reject_application', to: 'apply_admissions#reject_application', as: 'reject_application'
    get 'confirmation', to: "apply_admissions#confirmation", as: 'confirmation'
  end
  resources :users, :concerns => :paginatable
  resources :trade_fees, :concerns => :paginatable
  resources :student_faculties, :concerns => :paginatable
  resources :fees, :concerns => :paginatable
  resources :trades, :concerns => :paginatable
  resources :faculties, :concerns => :paginatable
  resources :students, :concerns => :paginatable do
    get :search, on: :collection
  end
  resources :exam_schedules, :concerns => :paginatable
  resources :collage_images, only: [:index, :create]
  resources :non_users, only: [:index, :new, :create]
  resources :subjects, :concerns => :paginatable
  resources :upload_fee_structures, except: [:edit, :update, :show]
  resources :charges, :concerns => :paginatable
  resources :export_files do
    collection do
      get 'export_file', to: 'export_files#export_file'
    end
  end
  resources :auto_complete do
    collection do
      get 'students', to: 'auto_complete#students'
    end
  end
  root to: 'home#index', as: :home

  require "sidekiq/web"
  mount Sidekiq::Web, at: '/sidekiq'
end
