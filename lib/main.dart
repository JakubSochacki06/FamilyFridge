import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'providers/google_signin_provider.dart';
import 'firebase_options.dart';
import 'screens/page_navigator.dart';
import 'screens/logging_page.dart';
import 'providers/firebase_user_provider.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    bool isLogged = FirebaseAuth.instance.currentUser == null ? false : true;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (context) => FirebaseUserProvider()),
      ],
      child: MaterialApp(
        title: 'FamilyFridge',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/landing': (context) => const LandingPage(),
          '/page_navigator': (context) => PageNavigator(),
          '/logging': (context) => LoggingPage(),
        },
        initialRoute: isLogged? '/page_navigator':'/landing',
      ),
    );
  }
}