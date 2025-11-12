

import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2C2C), // dark gray
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 109, 184), // light blue
        title: Text("Info & Safety"),
      ),
      body: ListView(
        padding: EdgeInsets.all(22),
        children: [
          Card(
            color: Color(0xFFF5F5F5), // near white
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Safety Tips',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 18, 109, 184), // light blue accent
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "• Always keep your emergency contacts up to date.\n"
                    "• Use the SOS button in emergencies for instant help.\n"
                    "• Share your live location if you feel unsafe.\n"
                    "• Regularly check the app for alerts and updates.\n"
                    "• Do not walk alone late at night, and inform someone about your whereabouts.",
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: Color(0xFFF5F5F5), // near white
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Manual',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color:Color.fromARGB(255, 18, 109, 184), // light blue accent
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "• Sync your smart watch with this app using the provided Bluetooth option on your Profile page.\n"
                    "• The app will automatically process health sensor data from your watch (like GSR, heart rate, etc).\n"
                    "• If a spike or anomaly is detected by the in-built machine learning safety model, an SOS alert is sent automatically to your emergency contacts with your latest location.\n\n"
                    "• This feature is especially useful in situations where you cannot trigger an alert manually.\n"
                    "• Make sure your watch is always connected and the app is running in the background for real time monitoring.",
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Text(
            "Stay safe and alert. Reach out to us for support anytime.",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

