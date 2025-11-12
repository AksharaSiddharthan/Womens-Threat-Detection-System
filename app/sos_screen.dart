

import 'package:flutter/material.dart';

class SOSScreen extends StatefulWidget {
  const SOSScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SOSScreenState createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> {
  bool alertSent = false;
  bool alarmOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2C2C), // dark gray
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 109, 184), // light blue
        elevation: 0,
        title: Text(
          "SOS Alert",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 180,
                child: CustomPaint(
                  painter: WavePainter(),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Large SOS activate button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF5F5F5), // near white
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 10,
                      ),
                      onPressed: alertSent
                          ? null
                          : () {
                              setState(() {
                                alertSent = true;
                              });
                              // Trigger SOS: send alert, location, etc.
                            },
                      child: Text(
                        alertSent ? "Alert Sent" : "Activate SOS",
                        style: TextStyle(
                          color: Color.fromARGB(255, 18, 109, 184), // light blue
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    // Live Location & status
                    Container(
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5), // near white
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.location_on, color:Color.fromARGB(255, 18, 109, 184), size: 30), // light blue
                          SizedBox(height: 8),
                          Text(
                            alertSent ? "Live location streaming..." : "GPS Ready",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 18, 109, 184), // light blue
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    // Toggle alarm sound
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            alarmOn ? Colors.white : Color(0xFF86C8FF), // light blue
                        backgroundColor:
                            alarmOn ? Color(0xFF86C8FF) : Color(0xFFF5F5F5),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: Icon(Icons.alarm),
                      label: Text(alarmOn ? "Alarm On" : "Ring Alarm"),
                      onPressed: () {
                        setState(() {
                          alarmOn = !alarmOn;
                        });
                        // Play/stop alarm sound logic here
                      },
                    ),
                    SizedBox(height: 24),
                    // Cancel/False Alarm
                    if (alertSent)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 18, 109, 184), // light blue
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          "Cancel Alert (False Alarm)",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        onPressed: () {
                          setState(() {
                            alertSent = false;
                            alarmOn = false;
                          });
                          // Cancel alert logic here
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Wavy light background painter
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xFFF5F5F5); // near white
    Path path = Path();
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.2, size.width, size.height * 0.5);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
