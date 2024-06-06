# WeatherAssessmentApp
## Overview
The WeatherAssessmentApp app is your go-to application for fetching current weather information for a specific location. With a user-friendly interface and advanced features, users can get real-time weather updates by entering a location or using the device's current location, user can also save locations name which could be used to fetch the weather information for that location anytime on the time. The app utilizes CoreLocation for location services, URLSession for network calls, and follows the MVVM design pattern for a well-organized and maintainable codebase.

## Features
- Location Detection: On the first launch, the app automatically detects the user's location using CoreLocation, providing the current weather for that location.
- Search Weather: Enter a specific location and hit the search button to get detailed weather information for that area.
- Current Location Weather: Utilize the "Current Location" button to quickly retrieve the current weather details based on the device's location.
- User-Friendly Interface: The app features an intuitive UI designed with UIKit and Storyboard for a seamless and visually appealing experience.
- InApp storage for fast and easy fetch of location weather information
## Links To Recording
- https://www.loom.com/share/424325b2d0f648e6b70f2e2c5fb6c25f?sid=94f7b22b-f982-4ff9-bb3d-82d89b15dccf

## Technologies Used
- UIKit: The app's user interface is implemented using the UIKit framework, ensuring a native and consistent iOS experience.
- CoreLocation: CoreLocation is utilized for location services, enabling the app to fetch the current weather based on the user's location.
- Storyboard: Interface design is created using Storyboard, providing a visual representation of the app's UI flow.
- MVVM Design Pattern: The Model-View-ViewModel design pattern is followed for clear organization and separation of concerns within the codebase.
- URLSession: Network calls are made using URLSession to fetch real-time weather data from the API.
- UserDefault: The app uses UserDefault to cache Locations name for easy and fast fetching of the location's weather information.
- Unit Testing: This is a software testing method where individual units or components of a software are tested in isolation to ensure they work as intended.

## Installation
To run the WeatherClima App, clone the repository and open the Xcode project file. Build and run the project on an iOS simulator or device.

```
git clone https://github.com/yourusername/weatherclima-app.git
cd weatherclima-app
open WeatherClima.xcodeproj
```
## Usage
Launch the app on your iOS device or simulator.
Allow location access if prompted.
On the first launch, the app detects your location and displays the current weather.
Use the search button to enter a specific location and get its weather details.
Alternatively, use the "Current Location" button to get the current weather information based on your device's location.
## License
This project is licensed under the MIT License.

Feel free to customize and enhance the app to suit your needs. If you have any questions or feedback, please contact okoosikorede@gmail.com.

Enjoy using the WeatherAssessmentApp!
