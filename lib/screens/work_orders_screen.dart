import 'package:flutter/material.dart';

class WorkOrdersScreen extends StatelessWidget {
  const WorkOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Ordres de travail',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
