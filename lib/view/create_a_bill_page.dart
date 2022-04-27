import 'package:craft/components/main_app_bar.dart';
import 'package:flutter/material.dart';

class CreateAbill extends StatefulWidget {
  const CreateAbill({Key? key}) : super(key: key);

  @override
  State<CreateAbill> createState() => _CreateAbillState();
}

class _CreateAbillState extends State<CreateAbill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: mainAppBar(title: "Create a bill"),
      body: Column(
        children: [],
      ),
    );
  }
}
