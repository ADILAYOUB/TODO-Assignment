import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLogoutPressed;

  const CustomAppBar({Key? key, required this.onLogoutPressed})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.pink.shade400,
      toolbarHeight: 100,
      elevation: 14,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(70),
          bottomLeft: Radius.circular(70),
        ),
      ),
      title: const Text(
        'Todo List',
      ),
      actions: [
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 7,
                    spreadRadius: 3,
                    color: Colors.pink,
                  ),
                ],
                shape: BoxShape.circle,
                color: Colors.pink.shade400,
              ),
              child: IconButton(
                onPressed: onLogoutPressed,
                icon: const Icon(
                  Icons.logout,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 26),
          ],
        ),
      ],
    );
  }
}
