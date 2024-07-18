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
    apiKey: 'AIzaSyBMYlGZvWQ5wumTMXh52gYxQZWJsUHhsVs',
    appId: '1:521069719833:web:e734b938a7f5fe79a41588',
    messagingSenderId: '521069719833',
    projectId: 'e-nable-545d3',
    authDomain: 'e-nable-545d3.firebaseapp.com',
    storageBucket: 'e-nable-545d3.appspot.com',
    measurementId: 'G-GGYKRBYW37',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBxPAyD00kiUZay9GM0UFrDRdMt-niW-Y',
    appId: '1:521069719833:android:a171ef283ec27124a41588',
    messagingSenderId: '521069719833',
    projectId: 'e-nable-545d3',
    storageBucket: 'e-nable-545d3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA0-91VkXoOYNggBv9NKIrImuTUssB5Fj8',
    appId: '1:521069719833:ios:a2e1ea57487dbaafa41588',
    messagingSenderId: '521069719833',
    projectId: 'e-nable-545d3',
    storageBucket: 'e-nable-545d3.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA0-91VkXoOYNggBv9NKIrImuTUssB5Fj8',
    appId: '1:521069719833:ios:a2e1ea57487dbaafa41588',
    messagingSenderId: '521069719833',
    projectId: 'e-nable-545d3',
    storageBucket: 'e-nable-545d3.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBMYlGZvWQ5wumTMXh52gYxQZWJsUHhsVs',
    appId: '1:521069719833:web:cfcf86902292bcd5a41588',
    messagingSenderId: '521069719833',
    projectId: 'e-nable-545d3',
    authDomain: 'e-nable-545d3.firebaseapp.com',
    storageBucket: 'e-nable-545d3.appspot.com',
    measurementId: 'G-0CL788FT7E',
  );
}
