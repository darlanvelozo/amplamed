import 'package:flutter/material.dart';

class VisuPage extends StatefulWidget {
  const VisuPage({Key? key}) : super(key: key);

  @override
  _VisuPageState createState() => _VisuPageState();
}

class _VisuPageState extends State<VisuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("informações"),
        ),
        backgroundColor: const Color(0xff4da5aa),
      ),
    );
  }
}
