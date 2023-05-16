import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/add_task_dialogue.dart';
import '../components/indicator_top_screen.dart';
import '../components/tasks.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: CustomAppBar(onLogoutPressed: signUserOut),
        extendBody: true,
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(36.0),
          child: FloatingActionButton(
            backgroundColor: Colors.pink.shade400,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTaskScreen(),
                ),
              );
            },
            child: const Icon(
              Icons.add,
              size: 28,
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              IndicationScreen(onPressed: signUserOut),
              const Expanded(
                child: Tasks(),
              ),
              const SizedBox(height: 16),
              Container(
                height: 40,
                color: Colors.white,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        'Completed',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: const Center(
                        child: Text(
                          '22',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
