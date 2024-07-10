// first_page.dart

// Just a simple placeholder widget page
// (in a real app you'd have something more interesting)
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Page')),
      body: const Center(
        child: Text('First Page'),
      ),
    );
  }
}
// SecondPage is identical, apart from the Text values