// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCPH-Mh_EZurd49bfohF0IkdB1Kut8ylk0',
    appId: '1:806573969478:web:5c11ad35f878628be4ba47',
    messagingSenderId: '806573969478',
    projectId: 'dumy-c76bc',
    authDomain: 'dumy-c76bc.firebaseapp.com',
    storageBucket: 'dumy-c76bc.firebasestorage.app',
    measurementId: 'G-K00V8P8V32',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD98VbeodO89xQG1dOadVGFbyD76d5tuWw',
    appId: '1:806573969478:android:52b3b1ee3567f994e4ba47',
    messagingSenderId: '806573969478',
    projectId: 'dumy-c76bc',
    storageBucket: 'dumy-c76bc.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD33Wm_BxAPevcVwj3u3Zm4OZLMj1VAzyc',
    appId: '1:806573969478:ios:c1260bef7bfa1d01e4ba47',
    messagingSenderId: '806573969478',
    projectId: 'dumy-c76bc',
    storageBucket: 'dumy-c76bc.firebasestorage.app',
    iosBundleId: 'com.example.firebaseBatch40',
  );
}
