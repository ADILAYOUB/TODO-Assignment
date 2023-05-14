import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/add_task_dialogue.dart';
import '../components/appbar.dart';
import '../components/tasks.dart';
import 'categories.dart';

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

  late int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(onLogoutPressed: signUserOut),
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink.shade400,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddTaskAlertDialog();
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: kBottomNavigationBarHeight,
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.pink.shade400,
              unselectedItemColor: Colors.black,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                  pageController.jumpToPage(index);
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'List',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: 'Category',
                ),
              ],
            ),
          ),
        ),
        body: PageView(
          controller: pageController,
          children: const <Widget>[
            Center(
              child: Tasks(),
            ),
            Center(
              child: Categories(),
            ),
          ],
        ),
      ),
    );
  }
}
