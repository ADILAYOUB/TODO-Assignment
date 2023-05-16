import 'package:flutter/material.dart';

import '../constants/strings.dart';

class IndicationScreen extends StatefulWidget {
  final void Function() onPressed;

  const IndicationScreen({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<IndicationScreen> createState() => _IndicationScreenState();
}

class _IndicationScreenState extends State<IndicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          StringConst().backgroundImage,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: widget.onPressed,
            icon: const Icon(
              color: Colors.white,
              Icons.logout,
              size: 24,
            ),
          ),
        ),
        const Positioned(
          top: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Things',
                style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 160),
              Text(
                'May 16, 2023',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const Positioned(
          top: 100,
          width: 130,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Text(
                    '1',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Person',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12),
              Column(
                children: [
                  Text(
                    '2',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Business',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Positioned(
          top: 180,
          right: 40,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: Colors.pink,
                strokeWidth: 10,
                value: 0.66,
              ),
              SizedBox(width: 10),
              Text(
                '66%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
