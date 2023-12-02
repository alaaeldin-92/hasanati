import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBlJ0XXj5Lirs0G7ff9dXXisIIAO_ublg4",
            authDomain: "hasanati-85079.firebaseapp.com",
            projectId: "hasanati-85079",
            storageBucket: "hasanati-85079.appspot.com",
            messagingSenderId: "151221629308",
            appId: "1:151221629308:web:675e4a363ffc015a0ab4f9",
            measurementId: "G-G7QFY1XT0J"));
  } else {
    await Firebase.initializeApp();
  }
}
