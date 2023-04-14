import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdwClamp.scrollable(
      child: Column(children: const [
        AdwTextField(
          autofocus: true,
          prefixIcon: Icons.search_outlined,
          keyboardType: TextInputType.text,
        )
      ]),
    );
  }
}
