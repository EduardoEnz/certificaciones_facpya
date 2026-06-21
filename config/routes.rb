Rails.application.routes.draw do
  get "pages/nosotros"
  get "pages/testimonios"
  get "pages/faq"
  get "leads/new"
  get "leads/create"
  get "certifications/index"
  get "certifications/show"
  get "home/index"
  root "home#index"

  resources :certifications, only: [:index, :show]
  resources :leads, only: [:new, :create]

  get "nosotros",             to: "pages#nosotros"
  get "testimonios",          to: "pages#testimonios"
  get "preguntas-frecuentes", to: "pages#faq", as: :faq

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end