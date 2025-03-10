Rails.application.routes.draw do
  get "enrollments/create"
  get "enrollments/destroy"
  get "courses/index"
  get "courses/show"
  root "courses#index"
  get "/dashboard", to: "students#dashboard", as: "dashboard"

  resources :students, only: [:new, :create]
  resources :courses, only: [:index, :show]
  resources :enrollments, only: [:create, :destroy]
  
  get "/login", to: "students#login"
  post "/login", to: "students#authenticate"
  delete "/logout", to: "students#logout"
  get "signup", to: "students#new"
  post "students", to: "students#create"
  get "/dashboard", to: "students#dashboard", as: "student_dashboard"
  get "/enrolled_courses", to: "students#enrolled_courses", as: "enrolled_courses"
  
end
