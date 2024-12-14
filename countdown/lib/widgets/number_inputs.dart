import 'package:flutter/material.dart';

import '../models/player.dart';
import '../models/round.dart';

class NumberInput extends StatefulWidget {
  final Player player;
  final Round round;
  final Function(int) onSubmit;

  NumberInput({required this.player, required this.round, required this.onSubmit});

  @override
  _NumberInputState createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  String _currentExpression = '';
  bool _isSubmitted = false;

  void _addToExpression(String value) {
    setState(() {
      _currentExpression += value;
    });
  }

  void _evaluateExpression() {
    try {
      final int result = int.parse(widget.round.numbers.join()) * 1; // Placeholder, для простоты пока умножаем на 1
      widget.onSubmit(result);
      setState(() {
        _isSubmitted = true;
      });
    } catch (e) {
      // Обработка ошибок парсинга
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid expression')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Player: ${widget.player.name}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(_currentExpression, style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: [
                ...widget.round.numbers.map((number) => ElevatedButton(
                      onPressed: !_isSubmitted ? () => _addToExpression('$number') : null,
                      child: Text('$number'),
                    )),
                ...['+', '-', '*', '/'].map((operator) => ElevatedButton(
                      onPressed: !_isSubmitted ? () => _addToExpression(operator) : null,
                      child: Text(operator),
                    )),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: !_isSubmitted ? _evaluateExpression : null,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
