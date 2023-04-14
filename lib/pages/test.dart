import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "test",
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
      ),
    );
  }
}
