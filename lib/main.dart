// import 'package:flutter/material.dart';
// import 'package:rekruters/Screens/Splashscreen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:rekruters/Screens/Loginscreen.dart';
// import 'package:rekruters/Screens/Homescreen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   late Future<bool> _loginStatus;
//
//   @override
//   void initState() {
//     super.initState();
//     _loginStatus = _checkLoginStatus();
//   }
//
//   Future<bool> _checkLoginStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('loginToken');
//     return token != null && token.isNotEmpty;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: FutureBuilder<bool>(
//         future: _loginStatus,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return  SplashScreen(); // Show splash screen while checking
//           } else if (snapshot.hasData && snapshot.data == true) {
//             return const HomeScreen(); // Redirect to HomeScreen if logged in
//           } else {
//             return const CandidateLoginScreen(); // Otherwise, go to LoginScreen
//           }
//         },
//       ),
//     );
//   }
// }
//
// // ✅ Splash Screen While Checking Login Status
//
import 'package:flutter/material.dart';
import 'package:rekruters/Screens/Splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rekruters/Screens/Loginscreen.dart';
import 'package:rekruters/Screens/Homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<bool> _loginStatus;

  @override
  void initState() {
    super.initState();
    // _loginStatus = _checkLoginStatus();
  }

  // Future<bool> _checkLoginStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('loginToken');
  //   return token != null && token.isNotEmpty;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen()
    );
  }
}



