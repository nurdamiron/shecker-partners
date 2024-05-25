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
    apiKey: 'AIzaSyBdUUS2HLIpKFa_5QHyTPf6rcFhKxHOtHQ',
    appId: '1:56911217429:web:c9b14521c62d7f149d1f1c',
    messagingSenderId: '56911217429',
    projectId: 'alash-sheker',
    authDomain: 'alash-sheker.firebaseapp.com',
    databaseURL: 'https://alash-sheker-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'alash-sheker.appspot.com',
    measurementId: 'G-6GKCE8YEDF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBObmlYMqtafNePW5QRm9ZO92jBDnHn-Yk',
    appId: '1:56911217429:android:ccc329198b4cb0929d1f1c',
    messagingSenderId: '56911217429',
    projectId: 'alash-sheker',
    databaseURL: 'https://alash-sheker-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'alash-sheker.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCM5uxckxBfbyP2H5tm4cKKPFObOMdf5Ww',
    appId: '1:831118677352:ios:10b7c9c39e2dbc2061f2dd',
    messagingSenderId: '831118677352',
    projectId: 'flareline',
    storageBucket: 'flareline.appspot.com',
    iosClientId: '831118677352-91v0f12ad6nhmn81v8d58es9aa6msiob.apps.googleusercontent.com',
    iosBundleId: 'top.flareline.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCM5uxckxBfbyP2H5tm4cKKPFObOMdf5Ww',
    appId: '1:831118677352:ios:8f4a105d5a23255961f2dd',
    messagingSenderId: '831118677352',
    projectId: 'flareline',
    storageBucket: 'flareline.appspot.com',
    iosClientId: '831118677352-emvut9cqckgcrl0foo0cv11a2d1l0lsv.apps.googleusercontent.com',
    iosBundleId: 'top.flareline.app.RunnerTests',
  );
}