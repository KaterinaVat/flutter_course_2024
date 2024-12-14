import 'package:flutter/foundation.dart';
import '../models/player.dart';
import '../models/round.dart';

class GameProvider with ChangeNotifier {
  List<Player> _players = [];
  List<Round> _rounds = [];
  int _currentRoundIndex = 0;
  Map<Player, int> _currentAttempts = {};

  List<Player> get players => _players;
  int get currentRoundIndex => _currentRoundIndex;
  List<Round> get rounds => _rounds;
  Map<Player, int> get currentAttempts => _currentAttempts;

  void initializeGame(List<String> playerNames, int numberOfRounds) {
    _players = playerNames.map((name) => Player(name: name, score: 0)).toList();
    _rounds = List.generate(numberOfRounds, (index) => Round.generateRound());
    _currentRoundIndex = 0;
    _currentAttempts = {};
    notifyListeners();
  }

  void submitAttempt(Player player, int attempt) {
    _currentAttempts[player] = attempt;
    notifyListeners();
  }

  void nextRound() {
    if (_currentRoundIndex < _rounds.length) {
      Round currentRound = _rounds[_currentRoundIndex];
      int target = currentRound.targetNumber;

      Player? roundWinner;
      int smallestDifference = double.maxFinite.toInt();

      _currentAttempts.forEach((player, attempt) {
        int difference = (target - attempt).abs();
        if (difference < smallestDifference) {
          smallestDifference = difference;
          roundWinner = player;
        }
      });

      if (roundWinner != null) {
        roundWinner!.score += 1;
      }

      _currentRoundIndex++;
      _currentAttempts = {};
      
      notifyListeners();
    }
  }

  bool isGameFinished() {
    return _currentRoundIndex >= _rounds.length;
  }

  List<Player> getLeaderboard() {
    List<Player> leaderboard = List.from(_players)
      ..sort((a, b) => b.score.compareTo(a.score));
    return leaderboard;
  }
}
