

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String age = '';
  String bloodGroup = '';
  String allergies = '';
  String medicalHistory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2C2C), // dark gray
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 109, 184), // light blue
        elevation: 0,
        title: Text(
          "Profile & Health Info",
          style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
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
                height: 150,
                child: CustomPaint(
                  painter: WavePainter(),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 44,
                        backgroundColor: Color(0xFFF5F5F5), // near white
                        child: Icon(Icons.person, size: 60,color: Color.fromARGB(255, 18, 109, 184)), // light blue
                      ),
                      SizedBox(height: 18),
                      Text(
                        "Personal & Medical Details",
                        style: TextStyle(
                          color: Color(0xFF86C8FF), // light blue
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      ),
                      SizedBox(height: 24),
                      _ProfileField(
                        label: "Full Name",
                        hint: "Enter your name",
                        icon: Icons.person_outline,
                        onSaved: (val) => name = val ?? '',
                      ),
                      SizedBox(height: 16),
                      _ProfileField(
                        label: "Age",
                        hint: "Your age",
                        icon: Icons.cake_outlined,
                        onSaved: (val) => age = val ?? '',
                        keyboard: TextInputType.number,
                      ),
                      SizedBox(height: 16),
                      _ProfileField(
                        label: "Blood Group",
                        hint: "Eg: B+ / O-",
                        icon: Icons.water_drop_outlined,
                        onSaved: (val) => bloodGroup = val ?? '',
                      ),
                      SizedBox(height: 16),
                      _ProfileField(
                        label: "Allergies",
                        hint: "E.g. Penicillin, Pollen",
                        icon: Icons.warning_amber_outlined,
                        onSaved: (val) => allergies = val ?? '',
                      ),
                      SizedBox(height: 16),
                      _ProfileField(
                        label: "Medical History",
                        hint: "Heart, Diabetes, etc.",
                        icon: Icons.health_and_safety_outlined,
                        onSaved: (val) => medicalHistory = val ?? '',
                        maxLines: 2,
                      ),
                      SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF5F5F5),
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(
                            "Save",
                            style: TextStyle(
                              color: Color(0xFF86C8FF), // light blue
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {
                            _formKey.currentState?.save();
                            // Save to database or API
                            // Add trigger history
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Profile Saved!"))
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final void Function(String?) onSaved;
  final TextInputType? keyboard;
  final int? maxLines;

  const _ProfileField({required this.label, required this.hint, required this.icon, required this.onSaved, this.keyboard, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      keyboardType: keyboard,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Color(0xFF86C8FF)), // light blue
        filled: true,
        fillColor: Color(0xFFF5F5F5), // near white
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

// Wavy light painter
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
