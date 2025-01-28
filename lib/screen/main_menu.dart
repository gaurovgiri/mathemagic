import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover),
      ),
      child: Center(
        child: SizedBox(
          width: 300,
          height: 200,
          child: Card(
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Mathemagica',
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 34,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Tap to play!", style: TextStyle(fontSize: 24)),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/game');
                      },
                      icon: const Icon(Icons.play_arrow,
                          size: 48, color: Color(0xFF000000)))
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
