# require 'rails_helper'

# RSpec.describe SessionsController, type: :controller do
#     context "Signing in a user" do
#         let(:user) { User.create(first_name: "John", last_name: "Doe", email: "johndoe@example.com", password: "password123") }
    
#         it "succeeds with valid credentials" do
#             post :create, params: { user: { email: user.email, password: "password123" } }
#             expect(response).to redirect_to('/news')
#             follow_redirect!
#             expect(response.body).to include("Signed in successfully.")
#         end
    
#         it "fails with invalid credentials" do
#             post :create, params: { user: { email: user.email, password: "wrongpassword" } }
#             expect(response).to redirect_to(new_user_session_path)
#             follow_redirect!
#             expect(response.body).to include("Invalid Email or password.")
#         end
#     end
#   end