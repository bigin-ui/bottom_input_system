import 'package:bottom_input_system/bottom_input_system.dart';
import 'package:flutter/cupertino.dart';
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

class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  late int selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Input System'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: BisFormBuilder(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 300,
              ),
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
                  items: const [
                    'Developer',
                    'Product Owner',
                    'Business Analysis',
                    'Product Designer',
                    'Project Coordinator',
                    'Quality Assurance'
                  ]),
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
