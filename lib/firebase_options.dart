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
    apiKey: 'AIzaSyDf-4ffm9em1f8LFdkVgVU8TKB8XMmRi7Q',
    appId: '1:599306273253:web:ec96116cdead2eeffbef0c',
    messagingSenderId: '599306273253',
    projectId: 'adil-asign-todo-a',
    authDomain: 'adil-asign-todo-a.firebaseapp.com',
    storageBucket: 'adil-asign-todo-a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyASVk37Um5_-3TyxN41zmI1nOlPstMhf5U',
    appId: '1:599306273253:android:f5c00962a8a99acafbef0c',
    messagingSenderId: '599306273253',
    projectId: 'adil-asign-todo-a',
    storageBucket: 'adil-asign-todo-a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANYq6ocndHo_S55bOrPhp7Fj2I_TpjnCM',
    appId: '1:599306273253:ios:935e3b3ea426ff66fbef0c',
    messagingSenderId: '599306273253',
    projectId: 'adil-asign-todo-a',
    storageBucket: 'adil-asign-todo-a.appspot.com',
    iosClientId: '599306273253-2k75j4jn6p0j1h18gcv5pb7pjgv134mo.apps.googleusercontent.com',
    iosBundleId: 'com.adilayoub.assignment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyANYq6ocndHo_S55bOrPhp7Fj2I_TpjnCM',
    appId: '1:599306273253:ios:9adb15efa2901444fbef0c',
    messagingSenderId: '599306273253',
    projectId: 'adil-asign-todo-a',
    storageBucket: 'adil-asign-todo-a.appspot.com',
    iosClientId: '599306273253-1qhtl54bqc2ddckeg6av20mnq1i8nms6.apps.googleusercontent.com',
    iosBundleId: 'com.adilayoub.assignment.RunnerTests',
  );
}
