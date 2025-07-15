// screens/profile_screen.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundColor: const Color(0xFF6C5CE7),
              child: const Text(
                'JD',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Profile Information Cards
            Card(
              elevation: 5,
              child: ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Color(0xFF6C5CE7),
                ),
                title: const Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                subtitle: const Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 5,
              child: ListTile(
                leading: const Icon(
                  Icons.email,
                  color: Color(0xFF6C5CE7),
                ),
                title: const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                subtitle: const Text(
                  'john.doe@email.com',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 5,
              child: ListTile(
                leading: const Icon(
                  Icons.phone,
                  color: Color(0xFF6C5CE7),
                ),
                title: const Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                subtitle: const Text(
                  '+1 (555) 123-4567',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.home),
                label: const Text('Go Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
