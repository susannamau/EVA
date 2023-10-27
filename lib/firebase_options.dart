// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC-Ku60rViahy5VzWp_XSib-DwieHc9dI4',
    appId: '1:106006254364:web:a54eac17e4ef04e0b9a0d9',
    messagingSenderId: '106006254364',
    projectId: 'elbaviva-7feb6',
    authDomain: 'elbaviva-7feb6.firebaseapp.com',
    databaseURL: 'https://elbaviva-7feb6-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'elbaviva-7feb6.appspot.com',
    measurementId: 'G-BF2291CT90',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB10HgZmUB1LR075fNC8OEdkd7Yz7KwP0Y',
    appId: '1:106006254364:android:0a7a00a4099096a9b9a0d9',
    messagingSenderId: '106006254364',
    projectId: 'elbaviva-7feb6',
    databaseURL: 'https://elbaviva-7feb6-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'elbaviva-7feb6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAi_9ln0SzPh10T8sjI7PYXAQmYdcW29D8',
    appId: '1:106006254364:ios:66ae8262ea9f7f71b9a0d9',
    messagingSenderId: '106006254364',
    projectId: 'elbaviva-7feb6',
    databaseURL: 'https://elbaviva-7feb6-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'elbaviva-7feb6.appspot.com',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAi_9ln0SzPh10T8sjI7PYXAQmYdcW29D8',
    appId: '1:106006254364:ios:3f32827baf98efe7b9a0d9',
    messagingSenderId: '106006254364',
    projectId: 'elbaviva-7feb6',
    databaseURL: 'https://elbaviva-7feb6-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'elbaviva-7feb6.appspot.com',
    iosBundleId: 'com.example.app.RunnerTests',
  );
}
