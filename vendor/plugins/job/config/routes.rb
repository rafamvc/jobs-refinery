ActionController::Routing::Routes.draw do |map|
  map.resources :jobs, :has_many => :job_applications
  map.resources :job_applications

  map.namespace(:admin) do |admin|
    admin.resources :jobs, :member => {:job_applications => :get}
  end
  
end
