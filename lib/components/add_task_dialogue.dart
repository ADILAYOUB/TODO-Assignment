import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'datetime.dart';
import 'text_form_filed.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();
  final List<String> taskTags = ['Work', 'School', 'Other'];

  AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 36.0),
          padding: const EdgeInsets.all(10.0),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Center(
          child: Text(
            'Add new thing',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.blue.shade800,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.access_alarm,
                    color: Colors.white,
                    size: 80,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2, 2),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      hint: const Text(
                        'Add task tag',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      value: null,
                      items: taskTags.map(
                        (item) {
                          return DropdownMenuItem<String>(
                            alignment: AlignmentDirectional.centerStart,
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.white),
                            ),
                          );
                        },
                      ).toList(),
                      style: const TextStyle(
                        color: Colors.white,
                      ), // Change the text color of the selected item
                      dropdownColor: Colors.blue
                          .shade800, // Change the background color of the dropdown menu
                      onChanged: (String? value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: taskDescController,
                hintText: 'Task',
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: taskDescController,
                hintText: 'Description',
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final taskName = taskNameController.text;
                  final taskDesc = taskDescController.text;
                  _addTasks(taskName: taskName, taskDesc: taskDesc);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade400,
                  minimumSize:
                      const Size(200, 50), // Increase the size of the button
                ),
                child:
                    const Text('ADD TO YOUR THING'), // Change the button text
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addTasks({
    required String taskName,
    required String taskDesc,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    final formattedDate = formatDate(DateTime.now());
    if (userId != null) {
      final taskData = {
        'taskName': taskName,
        'taskDesc': taskDesc,
        'taskTag': 'Work', // Replace with the selected task tag
        'userId': userId, // Store the user ID with the task
        "date": formattedDate,
      };

      try {
        final docRef =
            await FirebaseFirestore.instance.collection('tasks').add(taskData);
        final taskId = docRef.id;

        await FirebaseFirestore.instance
            .collection('tasks')
            .doc(taskId)
            .update({'id': taskId});

        _clearAll();
      } catch (e) {
        // print('Error adding task: $e');
      }
    }
  }

  void _clearAll() {
    taskNameController.text = '';
    taskDescController.text = '';
  }
}
