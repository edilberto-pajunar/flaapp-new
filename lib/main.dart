import 'package:firebase_core/firebase_core.dart';
import 'package:flaapp/services/networks/auth.dart';
import 'package:flaapp/services/networks/word.dart';
import 'package:flaapp/views/screens/auth/signup.dart';
import 'package:flaapp/views/screens/wrapper/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (context) => Auth()),
        ChangeNotifierProvider<Word>(create: (context) => Word()),
      ],
      child: const MaterialApp(
        home: AuthWrapperScreen(),
      ),
    );
  }
}
