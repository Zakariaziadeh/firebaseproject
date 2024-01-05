import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class companies extends StatefulWidget {
  const companies({Key? key}) : super(key: key);

  @override
  State<companies> createState() => _companiesState();
}

class _companiesState extends State<companies>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _industryController = TextEditingController();

  // Reference to the 'companies' collection in Firestore
  final CollectionReference companiesCollection =
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
      QuerySnapshot querySnapshot = await companiesCollection.get();

      if (querySnapshot.docs.isNotEmpty) {
        print('Collection "companies" exists!');

        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          print('Document ID: ${documentSnapshot.id}');
          print('Data: ${documentSnapshot.data()}');
        }
      } else {
        print('Collection "companies" does not exist.');
      }
    } catch (e) {
      print('Error checking collection existence: $e');
    }
  }

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String location = _locationController.text;
      String industry = _industryController.text;

      try {
        await companiesCollection.add({
          'name': name,
          'email': email,
          'location': location,
          'industry': industry,
        });

        print('Form data submitted successfully!');
      } catch (e) {
        print('Error submitting form data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Registration Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the company name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the company location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _industryController,
                decoration: const InputDecoration(labelText: 'Industry'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the company industry';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: submitForm,
                child: Text('Submit'),
              ),
              StreamBuilder(
                stream: companiesCollection.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text('No jobs available');
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var jobData = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
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
                                Text('Name: ${jobData['name']}'),
                                Text('Email: ${jobData['email']}'),
                                Text('Location: ${jobData['location']}'),
                                Text('Industry: ${jobData['industry']}'),
                                Text('Description: ${jobData['description']}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
