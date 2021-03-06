### Stock-Alert-Hack-Challenge

# Stock Alert
#### Stock Alert is an mobile assistant that lets you search and track your most important stocks! 
Note: This repository contains both the iOS frontend and the backend. 

Screenshots:
![Logging in](https://i.imgur.com/ceboDCa.png)
![User homepage](https://i.imgur.com/vbvxTlb.png)
![Adding stocks](https://i.imgur.com/alZ1G7O.png)
![Tweets](https://i.imgur.com/QpVEAxh.png)

### Description:
Stock Alert is an iOS app that allows a user to create an account and track stocks. Through a simple homepage, the user can view their stock prices and percent change. These bits of information are updated each time a user refreshes their homepage. Furthermore, the user can view the latest tweets on their stocks. 

### Meeting the requirements
#### iOS
The iOS portion contains two main screens accessible using the bottom navigation bar (UITabBarController). One screen allows users to view their favorited stocks and some of the basic information about each. We implemented this using a UITableView. The second main screen allows you to add a stock to your favorites and then saves it to your profile. 


#### Backend
The backend portion contains an api that acts as a communicator between the frontend and the various APIs we use. There are methods for creating and logging in users, adding stocks to a user's profile, and grabbing tweets on the user's stocks. The database is accessible through a Google Cloud VM under http://35.231.31.32/. 

Specifics: 
Possible GET requests include getting all users, a specific user, a user's homepage, updating a stock's price information, and the tweets related to a user's stocks.

Possible POST requests include creating a user, logging in, and adding a stock to the stocks a user is tracking. 

Possible DELETE requests include deleting a user, deleting a stock from the database, and deleting a stock from the list of stocks a user is tracking.
