import 'package:authapp/logout.dart';
import 'package:authapp/user/Usercompanies.dart';
import 'package:authapp/admin/jobs.dart';
import 'package:flutter/material.dart';

class userPanel extends StatefulWidget {
  const userPanel({super.key});

  @override
  State<userPanel> createState() => _userPanelState();
}

class _userPanelState extends State<userPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            logout(),
            GestureDetector(
              onTap: () {
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
                  MaterialPageRoute(
                      builder: (context) => const userCompanies()),
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
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
