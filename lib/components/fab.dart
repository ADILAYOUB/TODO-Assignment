import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTaskDialogue extends StatefulWidget {
  const AddTaskDialogue({super.key});

  @override
  State<AddTaskDialogue> createState() => _AddTaskDialogueState();
}

class _AddTaskDialogueState extends State<AddTaskDialogue> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'New Task',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.brown),
      ),
      content: SizedBox(
        height: height * 0.35,
        width: width,
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Task',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(CupertinoIcons.square_list,
                      color: Colors.brown),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
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
                  icon: const Icon(CupertinoIcons.bubble_left_bubble_right,
                      color: Colors.brown),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Row(
                children: <Widget>[
                  Icon(CupertinoIcons.tag, color: Colors.brown),
                  SizedBox(width: 15.0),
                  //TaskTags(),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.grey,
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Save'),
        ),
      ],
    );
  }
}
