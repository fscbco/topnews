require 'rails_helper'

RSpec.describe PagesController, type: :request do
    describe 'GET #home' do
        before do
            get '/'
        end

        it 'renders the home page' do
            expect(response).to render_template(root_path)
            expect(response).to be_successful
        end 
    end
end