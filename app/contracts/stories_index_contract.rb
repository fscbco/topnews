class StoriesIndexContract < Dry::Validation::Contract
  params do 
    optional(:filter).hash do 
      optional(:liked).filled(:bool)
    end
    optional(:page).filled(:integer, gt?: 0)
  end

end
