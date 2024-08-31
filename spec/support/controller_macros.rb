module ControllerMacros
    def login
        before(:each) do
            User.destroy_all #TODO: install DatabaseCleaner
            @user = FactoryBot.create(:user)
            @request.env['devise.mapping'] = Devise.mappings[:user]
            sign_in @user
        end
    end
end