# Evently App 📅

## Introduction

**Evently** is a modern mobile application developed using **Flutter** that allows users to discover, create, and manage events in an easy and interactive way. The application is designed to provide a smooth and intuitive experience where users can explore upcoming events, create their own events, and interact with event locations through an integrated map system.

The main objective of the project is to demonstrate how to build a full-featured Flutter application that integrates authentication, cloud databases, location services, and modern UI/UX design principles. Evently focuses on delivering a scalable and organized mobile application that follows best practices in Flutter development.

This project also showcases how developers can integrate powerful technologies such as **Firebase services, Google Maps APIs, and local storage** to create a fully functional event management platform. ([GitHub][1])

---

# Project Overview

Evently is designed to help users organize their daily activities and social events efficiently. Through the application, users can browse different types of events, view detailed information about each event, and save events they are interested in.

Users can also create new events by providing details such as event title, description, category, date, time, and location. These events are stored in a cloud database and can be viewed by other users in real time.

The application focuses on usability and accessibility by offering features like theme switching, multilingual support, and interactive maps.

---

# Main Features

## User Authentication

The application includes a secure authentication system that allows users to register and log in using their email and password. This authentication process is managed through Firebase, ensuring safe and reliable access control. ([GitHub][1])

## Event Creation

Users can create new events by entering all the necessary details such as:

* Event title
* Description
* Event category
* Date and time
* Event location
* Event image

Once created, the event is saved in the database and becomes available for other users to view.

## Event Discovery

The home screen of the application displays a list of available events. Users can browse through these events and view detailed information about each one.

Events may include different categories such as:

* Sports
* Meetings
* Gaming
* Workshops
* Birthdays
* Exhibitions
* Holidays

This categorization helps users easily find events that match their interests.

## Event Details

Each event contains detailed information including:

* Event title
* Description
* Event image
* Date and time
* Location
* Organizer information

Users can open the event details page to learn more about the event before deciding to participate.

## Google Maps Integration

Evently integrates **Google Maps** to display event locations. This allows users to visually locate events and navigate to them easily. ([GitHub][1])

## Favorites System

Users can mark events as favorites and quickly access them later from a dedicated favorites section. This feature helps users keep track of the events they are interested in.

## Search Functionality

The application provides a search feature that allows users to search for events using keywords such as the event title or description.

## Notifications

Users can receive notifications for upcoming events to ensure they never miss an event they are interested in.

## Theme Switching

Evently supports both **Light Mode and Dark Mode**, allowing users to customize the application's appearance according to their preference.

## Multi-Language Support

The application supports multiple languages such as **English and Arabic**, making it accessible to a wider audience. ([GitHub][2])

---

# Application Workflow

1. The user opens the application.
2. The user signs up or logs in.
3. The application loads the available events from the database.
4. Events are displayed on the home screen.
5. The user can browse events, search for events, or mark events as favorites.
6. Users can open event details to view full information.
7. The user can create a new event and add its details including location on the map.
8. The event is stored in the cloud database and becomes available to other users.

---

# Technologies Used

## Flutter

Flutter is the main framework used to develop the application. It allows developers to build cross-platform mobile applications using a single codebase.

## Dart

Dart is the programming language used for Flutter development.

## Firebase

Firebase provides several backend services for the application including:

* Firebase Authentication
* Cloud Firestore database
* Push notifications

## Google Maps API

Google Maps is integrated into the application to display event locations and allow users to interact with maps.

## Shared Preferences

Shared Preferences are used to store local settings such as user preferences, theme settings, and cached data.

---

# Project Structure

The project follows a modular structure to ensure maintainability and scalability.

Typical structure includes:

* **lib/**

  * models → Data models representing events and users
  * ui → Application screens and user interfaces
  * providers / state management → Managing application state
  * services → Handling API calls and Firebase operations
  * utilities → Helper functions and shared logic

* **assets/**

  * Images and graphical resources used in the application.

* **android / ios**

  * Platform-specific configurations.

---

# How to Run the Project

To run this project locally on your machine, follow these steps:

1. Clone the repository:

```
git clone https://github.com/mahmoud66844/Evently_App.git
```

2. Navigate to the project directory:

```
cd Evently_App
```

3. Install dependencies:

```
flutter pub get
```

4. Run the application:

```
flutter run
```

Make sure that you have Flutter installed and properly configured before running the application.

---

# Future Improvements

Although the current version of the application provides many useful features, several improvements can still be implemented in the future:

* Real-time chat between event participants
* Advanced filtering for events
* Event ticket booking system
* Calendar synchronization
* Improved UI animations
* Social media sharing for events

---

# Conclusion

The **Evently App** demonstrates how Flutter can be used to build a complete and scalable mobile application for event management. By combining Flutter with Firebase and Google Maps, the project provides a powerful platform that allows users to create, explore, and manage events easily.

This project highlights important Flutter development concepts such as UI design, state management, API integration, and cloud-based data handling, making it a strong example of a modern mobile application built with Flutter.

[1]: https://github.com/AYAEMAD0/Evently_App?utm_source=chatgpt.com "GitHub - AYAEMAD0/Evently_App"
[2]: https://github.com/mohamedzakaria9/evently_app?utm_source=chatgpt.com "GitHub - mohamedzakaria9/evently_app"
