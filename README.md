# MovieList

An app that shows list of movies. The app makes a request to a json to fetch movie list available, returns and displays the data from that query and displays the data in a list.

### App Overview:
The goal is to create a simple iOS application which makes a request to an JSON, parses the response, and displays the result in the UI. 

### Main Components:
The app consists of three main components:
- A MovieViewController: shows a list of available movies
- A DetailViewController consist of:
    - moview details
    - MovieTrailer Previewer


### Other components:
Other components in the app are:
- A detail component that is presented when a result item is tapped on is also available

# Requirements
- iOS Version ~> 13
- Xcode ~> 13 (10.0 compatible)
- Swift ~> 5.0

# Architecture
For this project I made use of an MVVM with Repository Pattern, using depedency injection to ensure separation of concerns and proper decoupling of code around the application. This separation of concern also makes the code easily testable.
I also made use of the coordinator pattern to manage the navigation flow around the app.

# Support
The application supports both light and dark modes.

# Performance Improvement
- Video caching, this saves the user's time and data
- Activity indicators to notify users of tasks
- LPLinkView is used to preview video before it is played

# Screenshots
Some screenshots of the app are shown below:

###  User Detail Dark Mode
/Users/sharon-omoyeni/Desktop/Simulator Screen Shot - iPhone 14 Pro - 2022-12-01 at 20.24.30.png

### User Detail Light Mode
/Users/sharon-omoyeni/Desktop/Simulator Screen Shot - iPhone 14 Pro - 2022-12-01 at 20.24.27.png

