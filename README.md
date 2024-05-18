# MovieFlix

## General
* iOS Native app written in Swift and SwiftUI that display a list of movies, and detail for every movie. 
* The data are retreived from [https://developers.themoviedb.org](url)
* App architecture is MVVM.
* Uses Dependency Injection for the NetworkService
* This app was developed exclusively for training reasons.
* Use main branch for evaluating

## Description

### Home View
* Developed in UIKit
* Supports pagination. App receives data in pages. When the user scrolls to the bottom of the list the app receives more data until there are none left
* Details. The user can click the movie he wants and can see more details by navigating to Detail View (Detail View)

### Detail View
* Developed in SwiftUI
* Details.Receives data from separate API
