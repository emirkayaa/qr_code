import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [QrImage(data: controller.text)],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField() {
    return TextField(
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.done)),
        labelText: 'Enter Data',
        border: const OutlineInputBorder(),
      ),
    );
  }
}
