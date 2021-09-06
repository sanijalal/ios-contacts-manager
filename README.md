# ios-contacts-manager
A small contact manager iOS application written in Swift.

This is written using the Model View Presenter - Coordinator pattern.

The Coordinator handles the coordination of the view controllers.

In each View Controller, the View Controller is written to be as dumb as possible. View Controller is responsible to handle user actions to presenter and to display the view with values returned by the presenter.

# Tests

Both UI and Unit tests can be found in the respective test targets.
