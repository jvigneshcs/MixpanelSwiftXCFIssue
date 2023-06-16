#!/bin/sh
set -o pipefail
set -e

NAME=MySDK
WORKSPACE="$NAME.xcworkspace"
GENERIC_PLATFORM=generic/platform=
PLATFORM_IOS=iOS
PLATFORM_IOS_SIMULATOR="iOS Simulator"
SDK_IOS=iphoneos
SDK_IOS_SIMULATOR=iphonesimulator
DERVIVED_DATA_PATH=build
ARCHIVE_RELEASE_PATH=artifacts/Archives/Release
MACROS="GCC_PREPROCESSOR_DEFINITIONS='$GCC_PREPROCESSOR_DEFINITIONS RELEASE=1'"
RELEASE_PATH=artifacts/Release

xcodebuild archive \
            -workspace $WORKSPACE \
            -scheme $NAME \
            ONLY_ACTIVE_ARCH=NO \
            ENABLE_BITCODE=YES \
            -destination "$GENERIC_PLATFORM$PLATFORM_IOS_SIMULATOR" \
            -derivedDataPath $DERVIVED_DATA_PATH \
            -archivePath "$ARCHIVE_RELEASE_PATH/$SDK_IOS_SIMULATOR" \
            -sdk iphoneos \
            $MACROS \
            SKIP_INSTALL=NO \
            BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
            | xcpretty --color

xcodebuild archive \
            -workspace $WORKSPACE \
            -scheme $NAME \
            ONLY_ACTIVE_ARCH=NO \
            ENABLE_BITCODE=YES \
            -destination "$GENERIC_PLATFORM$PLATFORM_IOS" \
            -derivedDataPath $DERVIVED_DATA_PATH \
            -archivePath "$ARCHIVE_RELEASE_PATH/$SDK_IOS" \
            -sdk iphonesimulator \
            $MACROS \
            SKIP_INSTALL=NO \
            BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
            | xcpretty --color

FRAMEWORK_RELATIVE_PATH="Products/Library/Frameworks/$NAME.framework"
ARCHIVE_EXTENSION=xcarchive
OUTPUT="$RELEASE_PATH/$NAME.xcframework"
rm -rf $OUTPUT

xcodebuild -create-xcframework \
            -framework "$ARCHIVE_RELEASE_PATH/$SDK_IOS.$ARCHIVE_EXTENSION/$FRAMEWORK_RELATIVE_PATH" \
            -framework "$ARCHIVE_RELEASE_PATH/$SDK_IOS_SIMULATOR.$ARCHIVE_EXTENSION/$FRAMEWORK_RELATIVE_PATH" \
            -output $OUTPUT
