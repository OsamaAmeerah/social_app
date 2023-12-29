import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text(
      'Users',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,

        fontSize: 30.0,
      ),
    ));
  }
}
