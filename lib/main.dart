import 'package:flutter/material.dart';
import 'package:runner/screen/gameplay.dart';
import 'package:runner/screen/main_menu.dart';

ValueNotifier<int> lives = ValueNotifier(5);
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Mathemagica());
}

class Mathemagica extends StatelessWidget {
  const Mathemagica({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MainMenu(),
        theme: ThemeData(fontFamily: 'Audiowide'),
        routes: {
          '/game': (context) => const MathemagicaGame(),
        });
  }
}
