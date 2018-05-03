Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  defaults format: :json do

    constraints( id: /\d+/) do

      resources :tasks

      resources :topologies do

        get 'nodes/count', to: 'nodes#count'
        resources :nodes, except: [:new, :edit]
        get 'nodes/:id/links', to: 'nodes#show_links'

      end
    end

  end
end
