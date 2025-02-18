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
    apiKey: 'AIzaSyChyPI5K-_0hVAidUEokEtTKGteQAhknBI',
    appId: '1:303034221829:web:5d8a9b0f4710b0c621e36c',
    messagingSenderId: '303034221829',
    projectId: 'flutter-firestore-55c33',
    authDomain: 'flutter-firestore-55c33.firebaseapp.com',
    storageBucket: 'flutter-firestore-55c33.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAb2xBLRe2ilQqSd7biM16lKuk35N1sH8U',
    appId: '1:303034221829:android:7ad42d73d0868d0f21e36c',
    messagingSenderId: '303034221829',
    projectId: 'flutter-firestore-55c33',
    storageBucket: 'flutter-firestore-55c33.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAAkXoSAz7Pa189vvexOUFquptcZeTqdUA',
    appId: '1:303034221829:ios:fa4331fb7708d33021e36c',
    messagingSenderId: '303034221829',
    projectId: 'flutter-firestore-55c33',
    storageBucket: 'flutter-firestore-55c33.firebasestorage.app',
    iosBundleId: 'com.example.flutterFirebaseFirestore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAAkXoSAz7Pa189vvexOUFquptcZeTqdUA',
    appId: '1:303034221829:ios:fa4331fb7708d33021e36c',
    messagingSenderId: '303034221829',
    projectId: 'flutter-firestore-55c33',
    storageBucket: 'flutter-firestore-55c33.firebasestorage.app',
    iosBundleId: 'com.example.flutterFirebaseFirestore',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyChyPI5K-_0hVAidUEokEtTKGteQAhknBI',
    appId: '1:303034221829:web:7669dd29aa47a63921e36c',
    messagingSenderId: '303034221829',
    projectId: 'flutter-firestore-55c33',
    authDomain: 'flutter-firestore-55c33.firebaseapp.com',
    storageBucket: 'flutter-firestore-55c33.firebasestorage.app',
  );
}
