require "rails_helper"

feature "Feature: User login/out", type: :system do
    include Devise::Test::IntegrationHelpers
    shared_examples :login_attempt do
        scenario 'login attempt' do
            visit root_path
        
            expect(page.current_path).to eq '/users/sign_in'
        
            fill_in('Email', with: email)
            fill_in('Password', with: password)
            click_on 'Log in'
        
            expect(page.current_path).to eq expected_path
        end
    end

    context 'valid user' do
        before :all do
            User.destroy_all # Until Database Cleaner or other methodology formalized
            @user_attrs = attributes_for(:user)
            User.create(@user_attrs)
        end
        
        describe 'CAN authenticate' do
            let!(:email) { @user_attrs[:email] }
            let!(:password) { @user_attrs[:password] }
            let!(:expected_path) { '/' }
            include_examples :login_attempt

        end

        scenario 'can logout' do
            user = User.first
            sign_in user

            visit root_path
            click_on 'Log out'

            expect(page.current_path).to eq new_user_session_path
        end
    end

    context 'invalid user' do
        describe 'CANNOT authenticate' do
            let!(:email) { 'nonexistent@example.com' }
            let!(:password) { 'foo-bar' }
            let!(:expected_path) { '/users/sign_in' }
            include_examples :login_attempt            
        end
    end
end
