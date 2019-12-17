![](https://github.com/sc4v3ng3r/animeapp_course/blob/development/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png?raw=true)
# Anime Store 

Anime Store is a simple, beautiful, lightweight and open source mobile app to streaming japanese animations "animes" without ADS and provide support to english and brazilian portuguese languages. You can see the daily releases, the top animes, the most viewed animes, the most recent episodes and also add animes to your personal list. 


<p float="left">
  <img src="https://s5.gifyu.com/images/app_startupf7a34bdb2ef8352f.gif" width="300" />
  <img src="https://s5.gifyu.com/images/home_to_details00ff993998186b6a.gif" width="300" /> 
  <img src="https://s5.gifyu.com/images/playbfba65960598f3e3.gif" width="300" />
</p>


The content which this app shows is hosted and handled by the brazilian website [anitube](https://www.anitube.site/). This app only fetches and parse the data from the website pages using the [anitube_crawler_api](https://github.com/sc4v3ng3r/anitube_crawler_api) and shows to the end user.

The app provide support english and brazilian portuguese languages but be aware that some data content will be only available in brazilian portuguese like animation subtitles. Due copyrights issues the app on Google Play is available only in Brazil but if you're in other country you can build the app very easy. The build process is described later in this document.

**I've no copyrights of the content and I am not the uploader and the keeper of the content. The propose of this app is educational and show some flutter development skills.**
 

# How to Install or Build

There is two ways to install Anime Store app. The first one and most easy is get the latest version on Google Play or get the source code, build the app and install it.

###  Getting the app on Google Play

[![Google Play](https://github.com/sc4v3ng3r/animeapp_course/blob/development/external_resources/badges/google-play-badge.png?raw=true)](https://play.google.com/store/apps/details?id=boaventura.com.br.anime_app)


### Building from the source (FLUTTER SDK IS REQUIRED)

1) Clone the repository. You can use **master branch** for published and stable app or **development branch** to get the app version with development features.

2) Open the project in an IDE of your preference.
3) In root directory run ``` flutter pub get ``` to fetch app dependencies.
4) In root directory run ```flutter packages pub run build_runner build --delete-conflicting-outputs ``` to generate required code with build_runner package.
5) In root directory run ```flutter run --profile``` To run the app with a better perfomance than debug mode.

**Notes:**
> * On Android ```flutter run --release``` build type will fail because you haven't the build release KEY.
> 
> * On iOS the app is running well but the Video Player Page was not tested on real Iphone device.