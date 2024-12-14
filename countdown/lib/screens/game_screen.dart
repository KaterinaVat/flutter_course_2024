import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game_provider.dart';
import '../models/player.dart';
import '../widgets/number_inputs.dart';
import 'lb_screen.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();

    if (gameProvider.isGameFinished()) {
      Future.microtask(() => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LeaderboardScreen(),
        ),
      ));
      return SizedBox.shrink();
    }

    final currentRound = gameProvider.rounds[gameProvider.currentRoundIndex];
    final players = gameProvider.players;

    return Scaffold(
      appBar: AppBar(
        title: Text('Round ${gameProvider.currentRoundIndex + 1}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Numbers: ${currentRound.numbers.join(', ')}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Target Number: ${currentRound.targetNumber}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, index) {
                  Player player = players[index];
                  return NumberInput(
                    player: player,
                    round: currentRound,  // Добавляем этот параметр
                    onSubmit: (int attempt) {
                      gameProvider.submitAttempt(player, attempt);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  gameProvider.nextRound();
                  if (gameProvider.isGameFinished()) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LeaderboardScreen(),
                      ),
                    );
                  } else {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => GameScreen()),
                    );
                  }
                },
                child: Text('Next Round'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
