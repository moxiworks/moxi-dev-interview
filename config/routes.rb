Rails.application.routes.draw do
  defaults format: :json do
    ## Terse `shallow` syntax
    # shallow do
    #   resources :events do
    #     resources :jobs do
    #       resources :shifts
    #     end
    #   end
    # end

    resources :events, only: [:index, :create, :show, :update, :destroy] do
      resources :jobs, only: [:index, :create]
    end

    resources :jobs, only: [:show, :update, :destroy] do
      resources :shifts, only: [:index, :create]
    end

    resources :shifts, only: [:show, :update, :destroy]

    resources :volunteers, only: [:index, :create, :show, :update, :destroy]
  end
end
