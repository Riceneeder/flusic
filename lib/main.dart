import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adwaita/adwaita.dart';
import 'package:libadwaita_bitsdojo/libadwaita_bitsdojo.dart';
import 'package:global_configs/global_configs.dart';

import 'pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfigs().loadJsonFromdir('asset/config.json');
  runApp(const MyApp());

  doWhenWindowReady(() {
    final win = appWindow!;
    const initialSize = Size(400, 450);
    const size = Size(1000, 600);
    win
      ..size = size
      ..alignment = Alignment.center
      ..minSize = initialSize
      ..show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AdwaitaThemeData.light(),
      darkTheme: AdwaitaThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
