import 'package:flutter/material.dart';
import 'dart:io';
import 'complete_profile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  String? age;
  String? birthDate;
  String? profileImagePath;
  bool isProfileCompleted = false;

  void _navigateToCompleteProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CompleteProfileScreen()),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        firstName = result["First Name"];
        lastName = result["Last Name"];
        phoneNumber = result["Phone Number"];
        address = result["Address"];
        age = result["Age"];
        birthDate = result["Date of Birth"];
        profileImagePath = result["Profile Image"];
        isProfileCompleted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isProfileCompleted && profileImagePath != null)
              CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(File(profileImagePath!)),
              ),
            SizedBox(height: 20),
            if (!isProfileCompleted)
              Center(
                child: ElevatedButton(
                  onPressed: _navigateToCompleteProfile,
                  child: Text("Complete Profile"),
                ),
              )
            else ...[
              buildSectionTitle("Personal Details"),
              buildProfileDetail("First Name", firstName),
              buildProfileDetail("Last Name", lastName),
              buildProfileDetail("Phone Number", phoneNumber),
              buildProfileDetail("Address", address),
              buildProfileDetail("Age", age),
              buildProfileDetail("Date of Birth", birthDate),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildProfileDetail(String title, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value ?? "-"),
        tileColor: Colors.grey[200],
      ),
    );
  }
}
