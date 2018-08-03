#! /usr/bin/env bash

      git clone https://Conley31@bitbucket.org/bythebook/mobile-app.git
      cd mobile-app

      rm app.json
      rm config.json

      curl https://bitbucket.org/Conley31/customerconfig/raw/efda04162c9d19e0b27e7a32bfc8a0bbecec4b3b/5b5742324a61bd1a3a9fcd32/app.json --output app.json
      curl https://bitbucket.org/Conley31/customerconfig/raw/efda04162c9d19e0b27e7a32bfc8a0bbecec4b3b/5b5742324a61bd1a3a9fcd32/config.json --output config.json
      curl https://bitbucket.org/Conley31/customerconfig/raw/efda04162c9d19e0b27e7a32bfc8a0bbecec4b3b/5b5742324a61bd1a3a9fcd32/splash.png --output splash.png

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
      # fastlane supply --track 'production' --json_key '<path/to/json_key.json>' --package_name "<your-package-name>" --apk "app.apk" --skip_upload_metadata --skip_upload_images --skip_upload_screenshots
      
      #### 6. Building iOS Standalone App ####
      expo build:ios --release-channel production
      curl -o app.ipa "$(expo url:ipa --non-interactive)"
      
      #### 7. Submit standalone iOS app to iTunes Connect ####
      # Make sure the following env variables are set
      # export DELIVER_USERNAME=<your-itunes-connect-email>
      # export DELIVER_PASSWORD=<your-itunes-connect-password>
      
      # Use fastlane to upload your current standalone iOS build to itc
      # fastlane deliver --verbose --ipa "app.ipa" --skip_screenshots --skip_metadata
      
      #### Misc ####
      # [Optional] You may or may not need to do this depending on your setup.
      # exp logout
      