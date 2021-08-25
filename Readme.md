# Football Information App

<p align="center">
  <img src="https://user-images.githubusercontent.com/41536381/130803482-727beadf-1512-4b4f-bc15-92dee388f3ec.png" height="70%" width="200"/>
</p>
<p align="center">
  <img src="https://user-images.githubusercontent.com/41536381/130803529-71598d56-951d-4a64-bdaa-59cb1699bd82.png" height="70%" width="200"/>
</p>

## Information

### What is this?

An app that displays information for football teams, displaying information about football teams such as: it's name, logo, squad and upcoming fixures.

### What can you do?

The user can select from a list of teams and display it's squad, upcoming fixures, it's logo and name.

## Notes from the developer

I started off by rearranging the project file structure. I always prefer to work in a clean environment and so it's important for me that everything is in it's place. After that I started wokring on the design. By looking at the API, I knew I had to use a generic network service since I'll be handling a few types of network requests so I created a network service that accepts any type, with an interactor to act as the middle-man between network logic and controller. This way I get to keep the controller dumb as to how things work behind the scenes, and also make my code scaleable and easy to change.
After the ground work was in place I started working on the UI. If I had more time, I'd add more network request types to support search, search(by: league/player), 
and so on. Another fun addition could have been more information in the team information screen.
I created a few custom cells to support the information I wanted for each section, and to make it easier to change and add to the view without it affecting functionality. 
Finally I added some fluff with color and icons, and appIcon to make the app look a little more appealing

All in all, it was a fun exercise, but I have to say that the API was quite problematic, especially with regards to the varying amounts of data sent with each call type, the amount of modelling required and the team's logos in SVG format, which proved to be more problematic in Swift than I anticipated.

Known bug: The team's logo in the team information screen should be centered, not on the left hand side of the screen. SVG format was problematic, and I didn't
have the time to make it work.

## Usage Instructions

### Requirements to run

- XCode 12.5.1 and above.
- Device/Simulator running iOS 14.5 and above.
- Cocoapods 1.10.1 or above.

### How to run

- Clone the repository or download the zip.
- Launch the 364Scores.xcworkspace
- Build and run the project on a simulator or a connected device.

## The Exercise

Your task is to create a football information app supporting the following requirements:

● A splash screen will be shown when the app is launched. Use whatever image you want for the splash screen.

● The app’s main screen will show a list of football teams. When a team is selected, the app will show:

o The team’s logo

o Names of players in the team

o A list of 10 (or fewer) upcoming matches for the team. You should show the name of the rival team, the date, and the competition (Champions League, Primera Division, etc.).

o Each of the above should be shown in its own View, but all should be visible in the main screen. Use scrollbars if needed.

For this exercise, you should implement the app in Swift.
Football information is available from https://www.football-data.org/.

## Author

Yreshef, <Yohai.Reshef.Dev@gmail.com>
