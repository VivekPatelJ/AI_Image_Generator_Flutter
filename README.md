# AI Image Generator Flutter Project

This Flutter application is a basic AI-based image generator that integrates with the Imagine API, a product of Midjourney AI, to create images based on user input prompts. The application currently features a single screen with a text input field for prompts and a "Generate" button to initiate image creation. Further functionality and updates will be added in future commits.

## Screen shots :
<p>
 <img src="https://github.com/user-attachments/assets/89fba77e-319c-4380-ab78-c8314da19596" alt="Image 1" width="200">
 <img src="https://github.com/user-attachments/assets/680d82c0-082b-453b-876a-723dcb0cf705" alt="Image 2" width="200">
 <img src="https://github.com/user-attachments/assets/b25beef9-4b4d-4355-b53d-54aeb75669bd" alt="Image 3" width="200">
</p>

## Features

- **Prompt Input**: Enter text prompts to describe the image you want to generate.
- **Generate Button**: Generates an AI image based on the input prompt.
- **Image Display**: Displays the generated image once it is received from the API.

## Requirements

- **Flutter SDK**: Ensure you have Flutter installed. You can check by running `flutter --version` in the terminal.
- **Dart SDK**: Included with Flutter, but verify by running `dart --version`.
- **Imagine API Key**: To use this app, you need an API key from Imagine by Midjourney AI.

## Getting Started

### Step 1: Clone the Repository

```bash
git clone https://github.com/your-username/ai-image-generator-flutter.git
cd ai-image-generator-flutter
```

### step 2 : Install Dependencies

- Run the following command to install necessary dependencies:
  
```bash
flutter pub get
```
### Step 3: Configure the API Key

- Obtain an API key from the Imagine product of Midjourney AI.
Open the prompt_repo.dart file located in lib/feature/prompt/repos/.
Replace YOUR_API_KEY with your actual API key in the following section:

```bash
const Map<String, dynamic> headers = {
  'Authorization': 'Bearer YOUR_API_KEY',
};
```
### Step 4: Run the Application

- To start the application, run:

```bash
flutter run
```

## Project Structure

- lib/: Contains all the main code files for the app.
- feature/prompt/: Includes UI, Bloc, and Repository components for handling prompt-based image generation.
- Bloc: Manages application state using the Bloc pattern.
- Repos: Contains the PromptRepo class, responsible for handling API requests.
- utils/: Contains utility files, including custom widgets like the AppBar.

## How to Use the App
- Launch the app on an emulator or a real device.
- Enter a descriptive prompt in the text input field (e.g., "A beautiful landscape with mountains and rivers").
- Press the "Generate" button to send the prompt to the Imagine API.
- The generated image will be displayed on the screen once the response is received.

## Troubleshooting
- Invalid API Key: Ensure you have replaced YOUR_API_KEY in prompt_repo.dart with a valid Imagine API key.
- Distorted Images: Check the image configurations in the API payload if images are not displaying as expected. You may need to adjust parameters like style_id, cfg, or aspect_ratio based on Imagine's documentation.
- Network Issues: Ensure that your device has a stable internet connection, as the app requires API access to generate images.

## Future Updates
- Planned future updates will include:
### Enhanced UI/UX.
- Additional image styles and configurations.
- Error handling improvements.
