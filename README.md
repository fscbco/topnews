# Top News: Internal Team News Feed

## How to run the app

Currently the app is only running locally.
* Assuming you're in the root directory, `rails s` to get the Rails server started. 
* In a separate terminal, navigate to the `Frontend` folder and do `npm start` to start the React server.
* Log in with one of the saved users and enjoy top stories from Hacker News!

## Note on Requirements

* Users should sign in. We have created a User model for you and pre-populated it with several users.
* Users should come to a page and see a list of current top Hacker News stories.
* This list does not necessarily need to be the current live list, but it should be a recent and continuously updated list.
    > The list is updated every time a user logs in

* The number of stories displayed is up to you.
    > Currently limiting the list to 20 articles, though that's easily configurable on the backend in 'ApiHelper' with `NUM_OF_STORIES` variable.

* The user should be able to star a story. The mechanism and display is up to you: flag, star, upvote, pick, etc. The UX is your choice.
* The stories chosen by the team members should display. It can be a separate page or the same page, the choice is yours.
    > For better UX, I decided to separate All Stories from Starred Stories. When looking at the All Stories view, current user will be able to star stories 
    > they havent' starred before, and they'll see which ones they've already starred. 
    > Only Starred view shows all the starred articles, whether they were starred by the current user or not, and indicates the name(s) of the user(s) who starred it.

* Each story should show the name of the team member or members who flagged it.
* As an internal tool for a small team, performance optimization is not a requirement.
    > I took this to heart and there are quite a few places where optimization could be useful.

* Be prepared to discuss known performance shortcomings of your solution and potential improvements.
* UX design here is of little importance. The design can be minimal or it can have zero design at all.

Tests were not part of the requirements. Were I to implement tests, I would do Rspec tests for the backend and Jest tests for the frontend.