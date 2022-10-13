# New Relic Code Challenge

## Assumptions
Kept the existing UI the same as I interupted it to look.
Download all the cats in batches of 30 at the start(The UI updates when each batch returns), instead of scrolling to download more.
I added a footer with an activity indicator instead of using the ones on the cells. I didn't remove that but could in the future.


## Navigation

### Using the coordinator pattern:
Create a main coordinator that will control our app flow, starting it when our app launches.

### Coordinator:
A property to store the navigation controller that’s being used to present view controllers. Using a navigation controller is the easiest way to present view controllers.
A start() method to make the coordinator take control. This allows us to create a coordinator fully and activate it only when we’re ready.
The MainCoordinator is where there are functions to push view controllers onto the navigation controller.

### SceneDelegate:
Modify didFinishLaunchingWithOptions so that it configures and starts our main coordinator, and also sets up a basic window for our app. That basic window is normally done by the storyboard, but it’s our responsibility.

### ViewControllerProvider:
An enum for getting new view controllers. Currently setup for the AllCatsViewController, CatDetailsViewController, and MetricsViewController.


## ViewModel

### CatsViewModel
Contains a cats variable and an allCatsDownloaded variable that are setup to trigger closures on update.
Call the requestAllCats function to start collecting the cat details. 
The requestMoreCats function calls itself recursively until the web call returns 0 cats.

#### Variable:
A class that holds a value and calls a closure when the value is set.
The value member of this class can be used to store just about anything. When value is changed it has a didset that calls the onUpdate closure. 
The onUpdate closure should be defined wherever you want to inform that the value was updated.

### CatsAPIResponseTimeManager
A simple class that holds an array of times and has a function to get their average.
