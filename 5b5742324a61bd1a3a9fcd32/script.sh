#! /usr/bin/env bash

      git clone https://Conley31@bitbucket.org/bythebook/mobile-app.git
      cd mobile-app

      rm app.json
      rm config.json

      curl https://raw.githubusercontent.com/conley31/customerConfig/master/5b5742324a61bd1a3a9fcd32/app.json --output app.json
      curl https://raw.githubusercontent.com/conley31/customerConfig/master/5b5742324a61bd1a3a9fcd32/config.json --output config.json
      curl https://raw.githubusercontent.com/conley31/customerConfig/master/5b5742324a61bd1a3a9fcd32/splash.png --output splash.png
      curl https://raw.githubusercontent.com/conley31/customerConfig/master/5b5742324a61bd1a3a9fcd32/logo.png --output logo.png


      #### 2. Script Setup ####
      # It's useful to exit the bash script when a command exits with a non-zero status
      # as the following commands must be run successfully in sequence for expected results.
      set -e
      
      # Install dependencies
      npm install
      
      # [Optional] Login to Expo using username & password
      # You may or may not need to do this depending on your setup.
      # Note the $EXPO_USERNAME and $EXPO_PASSWORD env variables
      # exp login -u $EXPO_USERNAME -p $EXPO_PASSWORD --non-interactive
      
      #### 3. Publish to Expo ####
      expo publish --release-channel production --non-interactive
      
      #### 4. Building Android Standalone App ####
      expo build:android --release-channel production --non-interactive --no-publish
      curl -o app.apk "$(expo url:apk --non-interactive)"
      
      #### 5. Submit and publish standalone Android app to the Google Play Store ####
      # Use fastlane to upload your current standalone android build
      # Customize this to fit your needs. Take note of env variables.
      # Check out https://docs.fastlane.tools for more info.
      fastlane supply --track 'production' --json_key 'google_auth.json' --package_name "com.ByTheBook.jakescodingshack" --apk "app.apk" --skip_upload_metadata --skip_upload_images --skip_upload_screenshots
      
      #### 6. Building iOS Standalone App ####
      expo build:ios --release-channel production
      curl -o app.ipa "$(expo url:ipa --non-interactive)"
      
      #### 7. Submit standalone iOS app to iTunes Connect ####
      # Make sure the following env variables are set
      export DELIVER_USERNAME=david@bythebook.com
      export DELIVER_PASSWORD=Dacgen15241524
      
      # Use fastlane to upload your current standalone iOS build to itc
      # fastlane deliver --verbose --ipa "app.ipa" --skip_screenshots --skip_metadata
      
      #### Misc ####
      # [Optional] You may or may not need to do this depending on your setup.
      # exp logout
      