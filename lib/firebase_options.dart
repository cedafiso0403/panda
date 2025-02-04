// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2b7KgLA3H6qqV5sCnNiN87YVu35makEM',
    appId: '1:801753182739:android:b52420aed9df521c6685e6',
    messagingSenderId: '801753182739',
    projectId: 'panda-project-a9b69',
    storageBucket: 'panda-project-a9b69.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA89sBbB6wrwIWV01ibYUL8kp0Q5jMCGG8',
    appId: '1:801753182739:ios:7589591486e2898a6685e6',
    messagingSenderId: '801753182739',
    projectId: 'panda-project-a9b69',
    storageBucket: 'panda-project-a9b69.appspot.com',
    iosBundleId: 'com.example.flutterPanda',
  );
}
