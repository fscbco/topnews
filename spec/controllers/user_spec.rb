require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    
    let(:valid_user) { FactoryBot.create(:user) }
    
    before do
        sign_in valid_user
    end
    
    # describe "GET #index" do
    #     it "renders the index template" do
    #         get :index
    #         expect(response).to render_template :index
    #     end
    # end
end