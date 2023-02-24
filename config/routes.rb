Rails.application.routes.draw do
  defaults format: :json do
    shallow do
      resources :events do
        resources :jobs do
          resources :shifts
        end
      end
    end

    resources :volunteers
  end
end
