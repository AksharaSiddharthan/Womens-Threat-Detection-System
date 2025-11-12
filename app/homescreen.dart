

// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Already on Home, do nothing
        break;
      case 1:
        Navigator.pushNamed(context, '/profile');
        break;
      case 2:
        Navigator.pushNamed(context, '/contacts');
        break;
      case 3:
        Navigator.pushNamed(context, '/info');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2C2C), // dark gray
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 109, 184), // light blue
        elevation: 0,
        title: const Text(
          'womensafety',
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold,
            fontSize: 28,
            letterSpacing: 2,
          ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SOS Button
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/sos');
                    },
                    child: SizedBox(
                      width: 130,
                      height: 130,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5), // near white
                          borderRadius: BorderRadius.circular(65),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 12,
                                offset: Offset(2, 8)),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "SOS",
                            style: TextStyle(
                              color: Color.fromARGB(255, 18, 109, 184), // light blue
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Quick Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _QuickAction(
                        icon: Icons.call,
                        label: "Call",
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Calling emergency contact..."))
                          );
                        },
                      ),
                      const SizedBox(width: 24),
                      _QuickAction(
                        icon: Icons.location_on,
                        label: "Location",
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Sharing location..."))
                          );
                        },
                      ),
                      const SizedBox(width: 24),
                      _QuickAction(
                        icon: Icons.alarm,
                        label: "Alarm",
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Alarm activated!"))
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // Mic button for speech detection
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/speech');
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              color: Color(0xFFF5F5F5), // near white
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.mic,
                              color:Color.fromARGB(255, 18, 109, 184), // light blue
                              size: 32,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Speech SOS",
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF5F5F5), // near white
        selectedItemColor:Color.fromARGB(255, 18, 109, 184), // light blue
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.contacts), label: "Contacts"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Info"),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

// Quick action button widget
class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon, 
    required this.label, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5), // near white
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color:Color.fromARGB(255, 18, 109, 184), size: 28), // light blue
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70, 
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}




class SpeechSOSScreen extends StatefulWidget {
  const SpeechSOSScreen({super.key});

  @override
  State<SpeechSOSScreen> createState() => _SpeechSOSScreenState();
}

class _SpeechSOSScreenState extends State<SpeechSOSScreen> {
  bool _isRecording = false;
  String? _audioPath;

  Future<void> _startRecording() async {
    // Simulated permission check and 'start recording'
    setState(() {
      _isRecording = true;
      _audioPath = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Recording started (simulated)!")),
    );
  }

  Future<void> _stopRecording() async {
    // Simulated 'stop recording' and set fake file path
    setState(() {
      _isRecording = false;
      _audioPath = "/fake/path/to/speech_sos.wav";
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Recording saved to $_audioPath (simulated)')),
    );
  }

  Future<void> _sendVoiceSOS() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('SOS voice message sent to emergency contacts! (simulated)')),
    );
    // Simulated upload/send logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2C2C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF86C8FF),
        title: const Text("Speech SOS"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.mic, size: 100, color: Color(0xFFF5F5F5)),
            const SizedBox(height: 30),
            if (_isRecording)
              Column(
                children: [
                  const Text('Recording... Speak now!',
                      style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.stop, color: Color(0xFF86C8FF)),
                    label: const Text('Stop Recording',
                        style: TextStyle(color: Color(0xFF86C8FF))),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5F5F5),
                      padding:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: _stopRecording,
                  ),
                ],
              ),
            if (!_isRecording && _audioPath == null)
              ElevatedButton.icon(
                icon: const Icon(Icons.fiber_manual_record,
                    color: Color(0xFF86C8FF)),
                label: const Text('Start Recording',
                    style: TextStyle(color: Color(0xFF86C8FF))),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5F5F5),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: _startRecording,
              ),
            if (!_isRecording && _audioPath != null)
              Column(
                children: [
                  const Text('Recording complete!',
                      style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 14),
                  ElevatedButton.icon(
                    icon:
                        const Icon(Icons.send, color: Color(0xFF86C8FF)),
                    label: const Text("Send to Emergency Contacts",
                        style: TextStyle(color: Color(0xFF86C8FF))),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5F5F5),
                      padding:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: _sendVoiceSOS,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}



// Wavy background painter
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xFFF5F5F5); // near white
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
