import 'package:assignment/components/update_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'delete_task.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);
  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: fireStore
            .collection('tasks')
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Text('No tasks to display');
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final taskDocs = snapshot.data!.docs;

          return ListView.separated(
            itemCount: taskDocs.length,
            separatorBuilder: (context, index) => Container(
              height: 2.0,
              color: Colors.grey,
            ),
            itemBuilder: (context, index) {
              final taskData = taskDocs[index].data()! as Map<String, dynamic>;

              IconData taskIconData = Icons.zoom_out_sharp;
              var taskTag = taskData['taskTag'];

              if (taskTag == 'Work') {
                taskIconData = Icons.work;
              } else if (taskTag == 'School') {
                taskIconData = Icons.school;
              }

              return SizedBox(
                height: 100,
                child: ListTile(
                  leading: Container(
                    width: 46,
                    height: 46,
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey, // Customize the border color
                        width: 2.0, // Customize the border width
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        taskIconData, // Replace with the desired icon
                        color: Colors.blue, // Customize the icon color
                      ),
                    ),
                  ),
                  title: Text(
                    taskData['taskName'],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    taskData['taskDesc'],
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  isThreeLine: true,
                  trailing: PopupMenuButton(
                    color: Colors.pink,
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 'edit',
                          child: const Text(
                            'Edit',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.white),
                          ),
                          onTap: () {
                            String taskId = taskData['id'];
                            String taskName = taskData['taskName'];
                            String taskDesc = taskData['taskDesc'];
                            String taskTag = taskData['taskTag'];
                            Future.delayed(
                              const Duration(seconds: 0),
                              () => showDialog(
                                context: context,
                                builder: (context) => UpdateTaskAlertDialog(
                                  taskId: taskId,
                                  taskName: taskName,
                                  taskDesc: taskDesc,
                                  taskTag: taskTag,
                                ),
                              ),
                            );
                          },
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: const Text(
                            'Delete',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.white),
                          ),
                          onTap: () {
                            String taskId = taskData['id'];
                            String taskName = taskData['taskName'];
                            Future.delayed(
                              const Duration(seconds: 0),
                              () => showDialog(
                                context: context,
                                builder: (context) => DeleteTaskDialog(
                                  taskId: taskId,
                                  taskName: taskName,
                                ),
                              ),
                            );
                          },
                        ),
                      ];
                    },
                  ),
                  dense: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
