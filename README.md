# Top News: Internal Team News Feed

On initiallization, you will need to run the job HackerNewsSyncJob once

Though I'm not crazy about it, I picked good_job because I felt it was the best fit, as
it has postgres support and doesn't need a seperate server, thus had minimal dependencies and a cleaner self contained solution

I introduced dry-validation for data validation. Strong parameters is one aspect of rails that is truly lacking. I prefer to use
a more robust data validation system and dry validation provides this.

I also pinned all non test/development gems to version numbers as this is good practice. 
Tied to the above point, I removed gems that are not being used. 

I also blew out code That wasn't being used, such as the /test folder



