import 'package:flutter/material.dart';

class Day16 extends StatelessWidget {
  const Day16({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Day 16'),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Row(children: [const Text('Hello'), const Text('Hello')]),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('Hello'),
            ),
          ],
        ),
      ),
    );
  }
}
