import 'package:fancy/healper/injections.dart';
import 'package:fancy/screens/home/homepage.dart';
import 'package:fancy/screens/login/login.dart';
import 'package:fancy/screens/login/signup.dart';
import 'package:fancy/screens/onboarding/onboarding.dart';
import 'package:fancy/screens/onboarding/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

Future<void> main() async {
  late FirebaseMessaging messaging;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );

  messaging.getToken().then((value) {
    print(value);
  });
  // await messaging.setAutoInitEnabled(true);
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    print("message recieved");
    print(event.notification!.body);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print('Message clicked!');
  });
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
  initializeSingletons();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fancy',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: false,
          // primarySwatch: Colors.grey,
          fontFamily: 'Raleway',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LogIn(),
          '/register': (context) => const SignUp(),
          '/home': (context) => const HomePage(),
          '/onboarding': (context) => const OnBoarding(),
        },
      ),
    );
  }
}
