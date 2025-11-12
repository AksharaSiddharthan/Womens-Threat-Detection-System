

import 'package:flutter/material.dart';
import 'package:womensafety/contact_screen.dart';
import 'package:womensafety/info_screen.dart';
import 'package:womensafety/profile_screen.dart';
import 'package:womensafety/sos_screen.dart';
import 'login.dart'; // Your Login screen
import 'homescreen.dart'; // Your Home (SOS Dashboard) screen
import 'register.dart';

void main() {
  runApp(WomensafetyApp());
}

class WomensafetyApp extends StatelessWidget {
  const WomensafetyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'womensafety',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Color(0xFF2C2C2C), // dark gray for app bar/icons
        scaffoldBackgroundColor: Color(0xFFF5F5F5), // near white for general background
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color.fromARGB(255, 18, 109, 184),     // light blue as accent
          secondary: Color(0xFFF5F5F5),   // near white for surfaces/buttons
          surface: Color(0xFFF5F5F5),
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 18, 109, 184), // light blue
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFF5F5F5), // near white
            foregroundColor: Color(0xFF2C2C2C), // dark gray text/icon
          ),
        ),
      ),
      home: HomeScreen(), // Change to HomeScreen() after login
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/contacts': (context) => ContactsScreen(),
        '/sos': (context) => SOSScreen(),
        '/info': (context) => InfoScreen(),
        //'/speech': (context) => SpeechSOSScreen(),
      },
    );
  }
}

