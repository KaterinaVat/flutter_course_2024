import 'dart:math';

class Round {
  final List<int> numbers;
  final int targetNumber;

  Round({required this.numbers, required this.targetNumber});

  // Генерируем раунд с случайными числами и целевым числом
  factory Round.generateRound() {
    final random = Random();
    List<int> smallNumbers = [];
    List<int> largeNumbers = [25, 50, 75, 100];
    
    // Генерируем шесть маленьких чисел
    for (int i = 0; i < 6; i++) {
      smallNumbers.add(random.nextInt(10) + 1); // числа от 1 до 10
    }

    // Выбираем одно большое число
    int largeNumber = largeNumbers[random.nextInt(largeNumbers.length)];

    // Генерируем все возможные числа
    List<int> allNumbers = List.from(smallNumbers);
    allNumbers[random.nextInt(smallNumbers.length)] = largeNumber;

    // Определяем целевое число
    int targetNumber = random.nextInt(900) + 100;

    return Round(numbers: allNumbers, targetNumber: targetNumber);
  }
}
