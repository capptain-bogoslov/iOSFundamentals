# MovieFlix

## General
* iOS Native app written in Swift and SwiftUI that display a list of movies, and detail for every movie. 
* The data are retreived from [https://developers.themoviedb.org](url)
* App architecture is MVVM.
* Uses Dependency Injection for the NetworkService
* This app was developed exclusively for training reasons.

## Description

### Home View
* Developed in UIKit
* Supports pagination. App receives data in pages. When the user scrolls to the bottom of the list the app receives more data until there are none left
* Refresh. The user can scroll up to refresh the received data. Developed with UIRefreshControl
* Search. When the user starts searching the list is updated with new data based on user's query
* Skeleton Loader. The table view use custom skeleton loader while we wait to receive data. When there is a pending request app shows 5 skeleton cells with animation. The skeleton Loader was developed natively with CAGradientLayer and CABasicAnimation
* Favourite movie. The user can select a movie as favourite by pressing the heart image. The user preferences are maintaining in UserDefaults
* Details. The user can click the movie he wants and can see more details by navigating to Detail View (Detail View)

### Detail View
* Developed in SwiftUI
* Details.Receives data from separate API
* Share. The user can share the link for this movie by pressing the share button. If the API does not contain a link the button is hidden
* Favourite movie. The user can select a movie as favourite by pressing the heart image. The user preferences are maintaining in UserDefaults
* Reviews. The View receives movie review data fro separate API and display only 2 reviews
* Similar Movies. The View receives similar movie data fro separate API
