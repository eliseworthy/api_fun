Elise::Application.routes.draw do
  get "pages/home"
  
  root :to => "pages#home"

  get "/:zip" => "pages#home"

end
