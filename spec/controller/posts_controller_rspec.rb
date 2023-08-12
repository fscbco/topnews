require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "POST #create" do
    let(:user) { User.create!(email: "test@example.com", password: "123123") }
    let(:valid_params) do
      {
        title: "Test Post",
        url: "https://example.com",
        id: 123
      }
    end
    
    context "when creating a post" do
      before do
        sign_in(user)
      end

      it "creates a new post" do
        expect {
          post :create, params: valid_params
        }.to change(Post, :count).by(1)
      end

      it "redirects to root_path after creating" do
        post :create, params: valid_params
        expect(response).to redirect_to(root_path)
      end

      it "sets a success flash message" do
        post :create, params: valid_params
        expect(flash[:success]).to eq("Liked post!")
      end
    end

    context "when encountering an error" do
      it "sets an alert flash message" do
        allow_any_instance_of(Post).to receive(:save!).and_raise(StandardError)
        post :create, params: valid_params
        expect(flash[:alert]).to eq("Something went wrong. Please try again.")
      end

      it "logs the error message" do
        allow_any_instance_of(Rails.logger).to receive(:info)
        allow_any_instance_of(Post).to receive(:save!).and_raise(StandardError)
        post :create, params: valid_params
        expect(Rails.logger).to have_received(:info).with(anything)
      end

      it "redirects to root_path after encountering an error" do
        allow_any_instance_of(Post).to receive(:save!).and_raise(StandardError)
        post :create, params: valid_params
        expect(response).to redirect_to(root_path)
      end
    end
  end
end