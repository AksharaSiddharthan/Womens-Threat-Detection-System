

import 'package:flutter/material.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Map<String, String>> contacts = [
    {'name': 'Mom', 'phone': '+911234567890'},
    {'name': 'Best Friend', 'phone': '+919112358132'},
  ];

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  // ignore: unused_element
  void _addContact() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Contact"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              _nameController.clear();
              _phoneController.clear();
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2C2C2C)),
            child: Text("Save"),
            onPressed: () {
              setState(() {
                contacts.add({
                  'name': _nameController.text,
                  'phone': _phoneController.text,
                });
              });
              _nameController.clear();
              _phoneController.clear();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  void _sendTestSOS(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Test SOS sent to $name!")),
    );
    // Add actual SMS/send logic here if required
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2C2C),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 109, 184), // light blue
        elevation: 0,
        title: Text(
          "Contacts",
          style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
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
                height: 140,
                child: CustomPaint(
                  painter: WavePainter(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical:16),
              child: Column(
                children: [
                  SizedBox(height: 12),
                  Expanded(
                    child: ListView.separated(
                      itemCount: contacts.length,
                      separatorBuilder: (context, idx) => SizedBox(height: 12),
                      itemBuilder: (context, idx) => Card(
                        color: Color(0xFF86C8FF), // light blue
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xFF2C2C2C),
                            child: Text(
                              contacts[idx]['name']![0],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            contacts[idx]['name']!,
                            style: TextStyle(
                                color: Color(0xFF2C2C2C),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          subtitle: Text(contacts[idx]['phone']!),
                          trailing: ElevatedButton.icon(
                            icon: Icon(Icons.send, color: Colors.white),
                            label: Text("Test SOS"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF2C2C2C),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () {
                              _sendTestSOS(contacts[idx]['name']!);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xFF2C2C2C),
                        backgroundColor: Color(0xFF86C8FF), // light blue
                        shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      icon: Icon(Icons.person_add, color: Color(0xFF2C2C2C)),
                      label: Text(
                        "Add Contact",
                        style: TextStyle(
                          color: Color(0xFF2C2C2C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _addContact,
                    ),
                  ),
                ],
              ),
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
    Paint paint = Paint()..color = Color(0xFF86C8FF); // light blue
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
