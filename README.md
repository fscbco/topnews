# Top News: Internal Team News Feed

On initialization, you will need to run the job HackerNewsSyncJob once

Though I'm not crazy about it, I picked good_job because I felt it was the best fit, as
it has postgres support and doesn't need a seperate server, thus had minimal dependencies and a more self contained solution for the purpose of this project

I inquired about whether it was ok to add some dependencies, but didn't hear back. So I made the assumption that I could

I introduced dry-validation for data validation. Strong parameters is one aspect of rails that is truly lacking. I prefer to use
a more robust data validation system and dry validation provides this.

I also pinned all non test/development gems to version numbers as this is good practice. 
Tied to the above point, I removed gems that are not being used. 

I also removed some code That wasn't being used, such as the /test folder

On the topic of tests, on a larger project I would use something like Factorybot, but didn't feel that was necessary here



