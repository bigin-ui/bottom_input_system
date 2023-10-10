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
        primaryColor: Colors.amber.shade700,
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
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              BisSelection(
                name: 'Role',
                decoration: const InputDecoration(
                  hintText: 'Select your role',
                ),
                items: [
                  'Developer',
                  'Product Owner',
                  'Business Analysis',
                  'Product Designer',
                  'Project Coordinator',
                  'Quality Assurance'
                ]
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 8,
              ),
              BisTextField(
                name: 'Name',
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
