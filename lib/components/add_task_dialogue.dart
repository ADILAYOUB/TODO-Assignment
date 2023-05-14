import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTaskAlertDialog extends StatefulWidget {
  const AddTaskAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskAlertDialog> createState() => _AddTaskAlertDialogState();
}

class _AddTaskAlertDialogState extends State<AddTaskAlertDialog> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();
  final List<String> taskTags = ['Work', 'School', 'Other'];
  late String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'New Task',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
      ),
      content: SizedBox(
        height: height * 0.35,
        width: width,
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: taskNameController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Task',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(
                    CupertinoIcons.square_list,
                    color: Colors.pink,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.pink.shade400,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: taskDescController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Description',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(
                    CupertinoIcons.bubble_left_bubble_right,
                    color: Colors.pink,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.pink.shade400,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: <Widget>[
                  const Icon(CupertinoIcons.tag, color: Colors.pink),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.pink.shade400,
                            width: 1.0,
                          ),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.all(16),
                      ),

                      isExpanded: true,
                      hint: const Text(
                        'Add a task tag',
                        style: TextStyle(fontSize: 14),
                      ),
                      //     ? 'Please select the task tag' : null,
                      items: taskTags
                          .map(
                            (item) => DropdownMenuItem<String>(
                              alignment: AlignmentDirectional.centerStart,
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) => setState(
                        () {
                          if (value != null) selectedValue = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final taskName = taskNameController.text;
            final taskDesc = taskDescController.text;
            final taskTag = selectedValue;
            _addTasks(taskName: taskName, taskDesc: taskDesc, taskTag: taskTag);
            Navigator.of(context, rootNavigator: true).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink.shade400,
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }

  Future<void> _addTasks(
      {required String taskName,
      required String taskDesc,
      required String taskTag}) async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    if (userId != null) {
      final taskData = {
        'taskName': taskName,
        'taskDesc': taskDesc,
        'taskTag': taskTag,
        'userId': userId, // Store the user ID with the task
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
        ('Error adding task: $e');
      }
    }
  }

  void _clearAll() {
    taskNameController.text = '';
    taskDescController.text = '';
  }
}
