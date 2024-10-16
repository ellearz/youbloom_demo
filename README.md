
# Youbloom App

Youbloom is a Flutter application that demonstrates OTP-based login and fetching concert data from an external API. The app consists of three main pages:

1. **Login Page**: Allows users to enter a mock phone number and OTP for verification.
2. **Main Page**: Displays a list of concerts fetched from an external API, with real-time filtering capabilities.
3. **Details Page**: Provides detailed information about a selected concert.

## Features

- **OTP Verification**: 
  - Users can log in using a predefined mock phone number and OTP.
  - Mock Phone Number: `+49123456789`
  - Mock OTP Code: `123456`

- **Data Fetching**: 
  - The app fetches concert data from an external API (`https://ellearz.github.io/youbloom/concert_data.json`).
  
- **Real-Time Filtering**: 
  - Users can filter the list of concerts in real-time using a search bar.

- **Concert Details**: 
  - When a concert is selected, users are taken to a details page that displays comprehensive information about the concert.


## Technologies Used

- Flutter
- Dart
- Dio (for HTTP requests)
- Bloc (for state management)
- Mocking with Mockito (for unit tests)

## Getting Started

To run the application on your local machine, follow these steps:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/ellearz/flutter_demo_project
   cd flutter_demo_project# youbloom_demo
