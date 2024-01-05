import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class userCompanies extends StatefulWidget {
  const userCompanies({Key? key}) : super(key: key);

  @override
  State<userCompanies> createState() => _userCompaniesState();
}

class _userCompaniesState extends State<userCompanies>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final CollectionReference userCompaniesCollection =
      FirebaseFirestore.instance.collection('companies');

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    checkIfCollectionExists();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void checkIfCollectionExists() async {
    try {
      QuerySnapshot querySnapshot = await userCompaniesCollection.get();

      if (querySnapshot.docs.isNotEmpty) {
        print('Collection "userCompanies" exists!');

        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          print('Document ID: ${documentSnapshot.id}');
          print('Data: ${documentSnapshot.data()}');
        }
      } else {
        print('Collection "userCompanies" does not exist.');
      }
    } catch (e) {
      print('Error checking collection existence: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('userCompanies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: userCompaniesCollection.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Text('No userCompanies available');
            }

            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var companyData =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name: ${companyData['name']}'),
                          Text('Email: ${companyData['email']}'),
                          Text('Location: ${companyData['location']}'),
                          Text('Industry: ${companyData['industry']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
