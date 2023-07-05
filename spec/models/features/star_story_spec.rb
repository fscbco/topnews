require 'rails_helper'

feature 'Starred Article Toggler', type: :system do
    before do
        @user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd', first_name: 'test', last_name: 'example')
        login_as(@user, :scope => :user)
        @story = Story.create!(author: 'Gary', story_id: rand(100000), time: DateTime.now, title: 'Garys Article', url: 'google.com')
    end

    it 'stars an article' do
        visit '/'

        click_link "Star this Story"
        expect(@user.reload.stories).to include(@story)

        click_link 'Starred Stories'
        expect(page).to have_current_path(root_path(filter: 'starred'))
        expect(page).to have_content(@story.title)
        expect(page).to have_content(@user.familiar_name)
    end

    it 'unstars an article' do
        @user.stories << @story
        visit '/'

        click_link 'Starred Stories'
        expect(page).to have_current_path(root_path(filter: 'starred'))
        expect(@user.stories).to include(@story)
        expect(page).to have_content(@story.title)
        expect(page).to have_content(@user.familiar_name)

        click_link 'Unstar this Story'
        expect(@user.stories).not_to include(@story)
        expect(current_path).to eq('/')

        click_link 'Starred Stories'
        expect(page).not_to have_content(@story.title)
    end
end