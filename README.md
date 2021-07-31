# GithubUser

### Environment
Xcode 12.5, deployment target 11.0 and above, written in Swift

### Setup
use `pod install` to setup the project

### Overview
The initial screen is `UserListViewController` embedded in a `UINavigationController` which shows a list of users. By tapping the row in `UserListViewController`, the app will transit to `RepositoryListViewController` which displays profile details and a list of unforked repositories from the selected user. By tapping the row in `RepositoryListViewController`, the app will transit to `BrowserViewController` which consists of a `WKWebView` and displays the content of repository url.

### API
The following APIs are used to get the needed information:
1. `GET/users`: Get a list of users shown in `UserListViewController`. Parameter `since` is needed for paging function.
2. `GET/users/{username}`: Get the profile of a specific user. The data is shown inside `UserProfileHeaderView` which is located on the top of `RepositoryListViewController`.
3. `GET/users/{username}/repos`: Get a list of public repositories for a specific user. The data is shown in the tableView inside `RepositoryListViewController`. Parameter `page` is needed for paging function.
