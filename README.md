### Stock-Alert-Hack-Challenge

# Stock Alert
#### Stock Alert is an mobile assistant that lets you search and track your most important stocks! 
Note: This repository contains both the iOS frontend and the backend. 

Screenshots:

### Description:
Stock Alert is an iOS app that allows a user to create an account and track stocks. Through a simple homepage, the user can view their stock prices and percent change. These bits of information are updated each time a user refreshes their homepage. Furthermore, the user can view the latest tweets on their stocks. 

### Meeting the requirements
#### iOS

#### Backend
The backend portion contains an api that acts as a communicator between the frontend and the various APIs we use. There are methods for creating and logging in users, adding stocks to a user's profile, and grabbing tweets on the user's stocks. The database is accessible through a Google Cloud VM under http://35.231.31.32/. 

Specifics: 
Possible GET requests include getting all users, a specific user, a user's homepage, updating a stock's price information, and the tweets related to a user's stocks.

Possible POST requests include creating a user, logging in, and adding a stock to the stocks a user is tracking. 

Possible DELETE requests include deleting a user, deleting a stock from the database, and deleting a stock from the list of stocks a user is tracking.
