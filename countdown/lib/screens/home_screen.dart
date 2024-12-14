import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game_provider.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _playerCountController = TextEditingController();
  final TextEditingController _roundCountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countdown Game Setup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Players (comma-separated):',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _playerCountController,
              decoration: InputDecoration(
                hintText: 'Player1, Player2, Player3',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Number of Rounds:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _roundCountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter number of rounds',
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Получаем имена игроков и количество раундов
                  List<String> playerNames = _playerCountController.text.split(',');
                  int numberOfRounds = int.tryParse(_roundCountController.text) ?? 3; // дефолтное значение - 3 раунда

                  // Инициализируем игру через провайдер
                  context.read<GameProvider>().initializeGame(playerNames, numberOfRounds);

                  // Переходим на экран игры
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GameScreen()),
                  );
                },
                child: Text('Start Game'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
