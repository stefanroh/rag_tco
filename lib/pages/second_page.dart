// first_page.dart

// Just a simple placeholder widget page
// (in a real app you'd have something more interesting)
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body: const Center(
        child: Text('Second Page'),
      ),
    );
  }
}
// SecondPage is identical, apart from the Text values