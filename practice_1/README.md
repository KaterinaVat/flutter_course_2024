## A sample command-line application providing basic argument parsing with an entrypoint in `bin/`.

### API Details

The application uses the [WeatherAPI](https://www.weatherapi.com/) to fetch weather data. The API provides a wide range of weather-related information, including current weather conditions, forecasts, and historical data.

### Set Up API Key

**Clone the Repository**:

   - Open the `bin/practice_1.dart` file.
   - Replace the placeholder `API_KEY` with your actual API key obtained from WeatherAPI.

   ```dart
   const String apiKey = 'your_api_key_here';
   ```


### Repository Implementation

The application implements a repository pattern for handling data fetching and processing. The `WeatherRepositoryWA` class is responsible for interacting with the WeatherAPI and retrieving weather data. The `WAApi` class handles the actual API calls and data parsing.

### New Feature: Weather by Coordinates

The WeatherRepositoryWA implementation now supports fetching weather data by coordinates (latitude and longitude). This feature is not supported by other repository implementations and will throw an UnimplementedError if used with them.

### Example

![изображение](https://github.com/user-attachments/assets/c19ce11a-1348-48de-b939-2c89d8a63065)

![изображение](https://github.com/user-attachments/assets/f6e73e60-557c-4eae-9b77-af4340824113)
