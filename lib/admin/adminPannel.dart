import 'package:authapp/admin/companies.dart';
import 'package:authapp/admin/jobs.dart';
import 'package:authapp/logout.dart';
import 'package:flutter/material.dart';

class adminPanel extends StatefulWidget {
  const adminPanel({super.key});

  @override
  State<adminPanel> createState() => _adminPanelState();
}

class _adminPanelState extends State<adminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            logout(),
            GestureDetector(
              onTap: () {
                print('object');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const jobs()),
                );
              },
              child: Container(
                width: 100.0,
                height: 100.0,
                color: Colors.blue,
                margin: const EdgeInsets.only(top: 250),
                child: const Center(
                  child: Text(
                    "jobs",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const companies()),
                );
              },
              child: Container(
                width: 100.0,
                height: 100.0,
                color: Colors.blue,
                margin: const EdgeInsets.only(top: 50),
                child: const Center(
                  child: Text(
                    "companies",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              width: 100.0,
              height: 100.0,
              color: Colors.blue,
              margin: const EdgeInsets.only(top: 50),
              child: const Center(
                child: Text(
                  "users",
                  style: TextStyle(color: Colors.white), // Optional: Text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
