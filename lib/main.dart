import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:qizo_2/home.dart';
import 'package:qizo_2/sign_up.dart';
import 'firebase_options.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: otplogin(),));
}
