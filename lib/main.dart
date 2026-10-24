import 'package:flutter/material.dart';
import 'pages/main_shell.dart';
import 'theme.dart';

void main() {
  runApp(const KopiKitaApp());
}

class KopiKitaApp extends StatelessWidget {
  const KopiKitaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kopi Kita',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const MainShell(),
    );
  }
}
