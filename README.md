# NEWZZ - News App

NEWZZ is a news app built using Flutter and powered by the [NewsAPI](https://newsapi.org/). This app provides users with real-time news updates, top headlines, breaking news, trending news, and news filtered by category and channel. 

![NEWZZ Thumbnail](https://raw.githubusercontent.com/makthakur28/NEWZZ/master/NewzzThumbnail.jpg)

## Features

- **Breaking News:** Stay updated with the latest and most important news stories.
- **Top Headlines:** Get the top headlines from various sources across the globe.
- **News by Category:** Explore news by specific categories such as Sports, Technology, Health, Entertainment, and more.
- **Trending News:** Discover trending stories in real-time.
- **Search News:** Search for specific news stories and get instant results.
- **News by Channel:** Read news from various popular channels like CNN, BBC, ABC News, and many more.

## Tech Stack

- **Flutter**: The app is built using Flutter for cross-platform mobile development.
- **Dio**: For handling API requests.
- **NewsAPI**: Fetches real-time news data from NewsAPI.
- **Clean Architecture**: The app follows a clean architecture to maintain separation of concerns and scalability.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [NewsAPI Key](https://newsapi.org/)

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/makthakur28/NEWZZ.git
    cd NEWZZ
    ```

2. Install dependencies:
    ```bash
    flutter pub get
    ```

3. Add your NewsAPI key:
    - Open `lib/core/api/api_constants.dart`
    - Replace `API_KEY` with your NewsAPI key.

4. Run the app:
    ```bash
    flutter run
    ```

## Contributions

Contributions are welcome! Feel free to open issues, fork the repository, and submit pull requests.

