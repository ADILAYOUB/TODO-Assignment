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

          return ListView.builder(
            itemCount: taskDocs.length,
            itemBuilder: (context, index) {
              final taskData = taskDocs[index].data()! as Map<String, dynamic>;

              Color taskColor = AppColors.blueShadeColor;
              var taskTag = taskData['taskTag'];

              if (taskTag == 'Work') {
                taskColor = AppColors.salmonColor;
              } else if (taskTag == 'School') {
                taskColor = AppColors.greenShadeColor;
              }

              return Container(
                height: 100,
                margin: const EdgeInsets.only(bottom: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      blurRadius: 5.0,
                      offset: Offset(0, 5), // shadow direction: bottom right
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    width: 20,
                    height: 20,
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: taskColor,
                    ),
                  ),
                  title: Text(taskData['taskName']),
                  subtitle: Text(taskData['taskDesc']),
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
