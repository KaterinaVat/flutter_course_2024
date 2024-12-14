import 'dart:math';

class Round {
  final List<int> numbers;
  final int targetNumber;

  Round({required this.numbers, required this.targetNumber});

  factory Round.generateRound() {
    final random = Random();
    List<int> smallNumbers = [];
    List<int> largeNumbers = [25, 50, 75, 100];
    
    for (int i = 0; i < 6; i++) {
      smallNumbers.add(random.nextInt(10) + 1);
    }

    int largeNumber = largeNumbers[random.nextInt(largeNumbers.length)];

    List<int> allNumbers = List.from(smallNumbers);
    allNumbers[random.nextInt(smallNumbers.length)] = largeNumber;

    int targetNumber = random.nextInt(900) + 100;

    return Round(numbers: allNumbers, targetNumber: targetNumber);
  }
}
