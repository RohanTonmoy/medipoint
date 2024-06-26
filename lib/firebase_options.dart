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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyB3dSw17Q7G-ASEcuQ8REufwy_YQLqYfnM',
    appId: '1:930344622459:web:b04be97854639cb9f405de',
    messagingSenderId: '930344622459',
    projectId: 'medipoint-90241',
    authDomain: 'medipoint-90241.firebaseapp.com',
    storageBucket: 'medipoint-90241.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXTUjFrNnNK9Ek1yqble95fnLg0dfqdgA',
    appId: '1:930344622459:android:d9c616713b8666bdf405de',
    messagingSenderId: '930344622459',
    projectId: 'medipoint-90241',
    storageBucket: 'medipoint-90241.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAwtQR8WCpL6ndHvuLaae8QwjFyuxw-X_8',
    appId: '1:930344622459:ios:bc91fbf9275969fef405de',
    messagingSenderId: '930344622459',
    projectId: 'medipoint-90241',
    storageBucket: 'medipoint-90241.appspot.com',
    iosBundleId: 'com.example.medipointFinal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAwtQR8WCpL6ndHvuLaae8QwjFyuxw-X_8',
    appId: '1:930344622459:ios:bc91fbf9275969fef405de',
    messagingSenderId: '930344622459',
    projectId: 'medipoint-90241',
    storageBucket: 'medipoint-90241.appspot.com',
    iosBundleId: 'com.example.medipointFinal',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB3dSw17Q7G-ASEcuQ8REufwy_YQLqYfnM',
    appId: '1:930344622459:web:70c45ed1a6e35f25f405de',
    messagingSenderId: '930344622459',
    projectId: 'medipoint-90241',
    authDomain: 'medipoint-90241.firebaseapp.com',
    storageBucket: 'medipoint-90241.appspot.com',
  );
}