import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartAgriculture/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartAgriculture/authpage.dart';
import 'package:smartAgriculture/new_data.dart';
import 'package:smartAgriculture/services/notifi_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

final navigatorkey = GlobalKey<NavigatorState>();


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
return  ScreenUtilInit(
        designSize: const Size(450, 900),
        builder: (context, child) {
          return MaterialApp(
            title: 'Smart Agriculture',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Inter'),
            home: const HomePage(),
          );
        });

  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Scaffold(
        body:   StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something Went Wrong'));
            } else if (snapshot.hasData) {
            return  const SmartDashBoard();
            } else {
    
             return const AuthPage();
            }
          },
        ),
      ),
    );
  }
}