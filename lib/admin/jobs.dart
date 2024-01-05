import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class jobs extends StatefulWidget {
  const jobs({Key? key}) : super(key: key);

  @override
  State<jobs> createState() => _jobsState();
}

class _jobsState extends State<jobs> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _industryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final CollectionReference jobsCollection =
      FirebaseFirestore.instance.collection('jobs');

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
      QuerySnapshot querySnapshot = await jobsCollection.get();

      if (querySnapshot.docs.isNotEmpty) {
        print('Collection "jobs" exists!');

        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          print('Document ID: ${documentSnapshot.id}');
          print('Data: ${documentSnapshot.data()}');
        }
      } else {
        print('Collection "jobs" does not exist.');
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
      String description = _descriptionController.text;

      try {
        await jobsCollection.add({
          'name': name,
          'email': email,
          'location': location,
          'industry': industry,
          'description': description,
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
        title: Text('Job Application Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(labelText: 'Location'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your location';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _industryController,
                    decoration: const InputDecoration(labelText: 'Industry'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your industry';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: submitForm,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            StreamBuilder(
              stream: jobsCollection.snapshots(),
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
            ),
          ],
        ),
      ),
    );
  }
}
