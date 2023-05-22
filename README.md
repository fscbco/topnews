I never used ROR to write front end code. It was interesting, and I learned alot, but I need to take extra time to learn how to write the front end with Ruby.

# Requirements I implemented
* Users should sign in. (I actually built the session MVC but I did not push them up becuase later I learned that the devise gem could replace those code. I am happy to push this up if you want to see them)
* Users should come to a page and see a list of current top 10 Hacker News stories.
* This list does not necessarily need to be the current live list, but it should be a recent and continuously updated list.

I used low level caching - I did not think that it was necessary to save the entire stories in the database since we want to continusly update list. There were other options that I would consider such as polling, push-notification, crone job and socket. But, I thought the cashe is most effienct for the scale of this project.

## Requirements I missed
If I had more time to work on this reequirement, I would have created a model which would save the information of the flagged stories as well as who saved it in the database, so it would be persistant.

* The user should be able to star a story.
* The stories chosen by the team members should display. It can be a separate page or the same page, the choice is yours.
* Each story should show the name of the team member or members who flagged it.


## out of scope
* performance optimization
* UX design
