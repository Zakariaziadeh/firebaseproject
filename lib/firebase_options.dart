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
    apiKey: 'AIzaSyDCbku8elaiL0EE4ZXI9YHqJzDBqAdgXSU',
    appId: '1:602613468498:web:82531a1cb77f6ae5b67e8b',
    messagingSenderId: '602613468498',
    projectId: 'flutterfirebaseproject-1e601',
    authDomain: 'flutterfirebaseproject-1e601.firebaseapp.com',
    storageBucket: 'flutterfirebaseproject-1e601.appspot.com',
    measurementId: 'G-L5WZ70VWKY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBnqc6k6NXixAwgPMQ7R3NwS42Lfx3EbdU',
    appId: '1:602613468498:android:bf990aaa09f53215b67e8b',
    messagingSenderId: '602613468498',
    projectId: 'flutterfirebaseproject-1e601',
    storageBucket: 'flutterfirebaseproject-1e601.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCID0837o0YTKP7an0r-y_D6_GLk5N3Ejw',
    appId: '1:602613468498:ios:16fc3cef5dc40b65b67e8b',
    messagingSenderId: '602613468498',
    projectId: 'flutterfirebaseproject-1e601',
    storageBucket: 'flutterfirebaseproject-1e601.appspot.com',
    iosBundleId: 'com.example.authapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCID0837o0YTKP7an0r-y_D6_GLk5N3Ejw',
    appId: '1:602613468498:ios:822a3fe6cbcde824b67e8b',
    messagingSenderId: '602613468498',
    projectId: 'flutterfirebaseproject-1e601',
    storageBucket: 'flutterfirebaseproject-1e601.appspot.com',
    iosBundleId: 'com.example.authapp.RunnerTests',
  );
}
