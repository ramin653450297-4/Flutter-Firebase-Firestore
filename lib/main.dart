import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.indigo,
      ),
      home: const StudentListScreen(),
    );
  }
}

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  void _showStudentDialog({DocumentSnapshot? student}) {
    TextEditingController nameController =
        TextEditingController(text: student?['name'] ?? '');
    TextEditingController studentIdController =
        TextEditingController(text: student?['student_id'] ?? '');
    TextEditingController yearController =
        TextEditingController(text: student?['year'] ?? '');
    TextEditingController majorController =
        TextEditingController(text: student?['major'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          student == null ? 'Add New Student' : 'Edit Student',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(nameController, 'Name'),
            _buildTextField(studentIdController, 'Student ID'),
            _buildTextField(yearController, 'Year'),
            _buildTextField(majorController, 'Major'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              var data = {
                'name': nameController.text.isNotEmpty ? nameController.text : 'Unknown',
                'student_id': studentIdController.text.isNotEmpty ? studentIdController.text : 'N/A',
                'year': yearController.text.isNotEmpty ? yearController.text : 'N/A',
                'major': majorController.text.isNotEmpty ? majorController.text : 'N/A',
              };

              if (student == null) {
                students.add(data); // Add new student
              } else {
                students.doc(student.id).update(data); // Update existing student
              }

              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }

  void _deleteStudent(String id) {
    students.doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
    'Student List',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white, 
    ),
  ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: students.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No students found.'));
          }

          return ListView(
            padding: const EdgeInsets.all(10),
            children: snapshot.data!.docs.map((student) {
              final studentData = student.data() as Map<String, dynamic>;

              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  title: Text(
                    studentData['name'] ?? 'Unknown',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                    'ID: ${studentData['student_id'] ?? 'N/A'} | '
                    'Year: ${studentData['year'] ?? 'N/A'} | '
                    'Major: ${studentData['major'] ?? 'N/A'}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showStudentDialog(student: student),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteStudent(student.id),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showStudentDialog(),
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }
}