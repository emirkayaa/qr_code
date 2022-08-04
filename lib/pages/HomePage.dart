import 'package:flutter/material.dart';
import 'package:qr_code/pages/scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              QrImage(size: 200, data: controller.text),
              buildTextField(context),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Scanner()));
                },
                child: const Text('Tarat'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 16, left: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.done),
          ),
          labelText: 'Enter Data',
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
