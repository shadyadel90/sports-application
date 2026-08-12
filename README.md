# Sports Application

An iOS sports application built with UIKit that lets users browse sports and leagues, inspect league and team details, and save favourite leagues for offline access.

## Highlights

- UIKit-based iOS application
- Presenter-driven architecture across feature modules
- Sports and league browsing
- League details and upcoming events
- Team details
- Favourite leagues persisted with Core Data
- Networking with Alamofire
- Image loading with Kingfisher
- Unit tests for core flows

## Architecture

The project is split into feature-oriented modules such as:

- `AllSports`
- `Leagues`
- `LeaguesDetails`
- `Favourite Leagues`
- `TeamDetails`

Presentation logic is separated into presenter types where applicable, while persistence is handled through a dedicated Core Data manager.

## Tech Stack

Swift, UIKit, Core Data, Alamofire, Kingfisher, XCTest, Swift Package Manager

## Tests

The repository includes XCTest coverage for sports and favourite-league behavior under `SportsAppTests`.

## Run locally

1. Clone the repository.
2. Open `SportsApp/SportsApp.xcodeproj` in Xcode.
3. Resolve Swift Package Manager dependencies.
4. Build and run on an iOS Simulator.
