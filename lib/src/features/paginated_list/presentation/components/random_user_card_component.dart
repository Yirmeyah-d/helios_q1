import 'package:flutter/material.dart';

import '../../domain/entities/user.dart';

class RandomUserCard extends StatelessWidget {
  final User user;
  const RandomUserCard({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text("Firstname: ${user.name.firstName}")),
            ],
          ),
          Row(
            children: [
              Expanded(child: Text("Lastname: ${user.name.lastName}")),
            ],
          ),
          Row(
            children: [
              Expanded(child: Text("Email: ${user.email}")),
            ],
          ),
        ],
      ),
    );
  }
}
