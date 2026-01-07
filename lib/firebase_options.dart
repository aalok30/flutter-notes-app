import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'Web is not configured for this Firebase project.',
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;

      case TargetPlatform.iOS:
        return ios;

      case TargetPlatform.macOS:
        return ios;

      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'This platform is not supported.',
        );
    }
  }

  /// ANDROID
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB99FT-MadSC8Abo0wbAbvlEMQ7Oa1DMWc',
    appId: '1:532306040206:android:6fd5f753176dd18f5dc0df',
    messagingSenderId: '532306040206',
    projectId: 'noteapp-94b56',
    storageBucket: 'noteapp-94b56.firebasestorage.app',
  );

  /// iOS
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB99FT-MadSC8Abo0wbAbvlEMQ7Oa1DMWc',
    appId: '1:532306040206:ios:8261693b0069207f5dc0df',
    messagingSenderId: '532306040206',
    projectId: 'noteapp-94b56',
    storageBucket: 'noteapp-94b56.firebasestorage.app',
    iosBundleId: 'com.note.app',
  );
}
