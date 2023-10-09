import 'package:bottom_input_system/bottom_input_system.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Input System Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const FormExample(),
    );
  }
}

class FormExample extends StatelessWidget {
  const FormExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Bottom Input System'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BisFormBuilder(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BisTextField(
                name: 'Email',
                initialValue: 'tam.mai@bigin.vn',
              ),
              const SizedBox(
                height: 8,
              ),
              BisTextField(
                name: 'Password',
                initialValue: '3nanaPotat0',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
