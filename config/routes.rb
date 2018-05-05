Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  defaults format: :json do

    constraints( id: /\d+/) do

      resources :tasks, except: [:new, :edit]

      resources :topologies, except: [:new, :edit] do

        get 'nodes/count', to: 'nodes#count'
        resources :nodes, except: [:new, :edit]
        get 'nodes/:id/links', to: 'nodes#show_links'
        resources :links, except: [:new, :edit]

      end
    end

  end
end
