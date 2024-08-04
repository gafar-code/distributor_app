import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBFA0zosR2gfJCeSOMgXSmuFbstCTuFiUo",
            authDomain: "sales-3t1asd.firebaseapp.com",
            projectId: "sales-3t1asd",
            storageBucket: "sales-3t1asd.appspot.com",
            messagingSenderId: "1031288970059",
            appId: "1:1031288970059:web:11c8782796981bb5b066ce"));
  } else {
    await Firebase.initializeApp();
  }
}
