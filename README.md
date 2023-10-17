# amazon_chime_plugin(WIP)

A new Flutter plugin project.
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Permissions

### 1. When iOS app, need to add code below to Podfile.

```
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
      # Ref: https://pub.dev/packages/permission_handler
      # From here
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',
        'PERMISSION_CAMERA=1',
        'PERMISSION_MICROPHONE=1',
      ]
      # to here
    end
  end
end

```

## メモ

1. 現状 Android の plugin および`example`の Android のアプリは、Lint がうまく通らない
   1. app/`build.gradle`にオプションを定義して、該当の Lint の適用を外そうとしてもうまく効かない
2. Plugin の Android のコードを直接`./gradlew build`でビルドしようとしても、ビルドできない
   1. `example`の Android アプリの方は、`./gradlew assembleDebug`(lint をせずに、ビルドのみ実行)は実行可能
