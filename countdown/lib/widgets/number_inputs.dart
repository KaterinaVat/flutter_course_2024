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
  Set<int> _usedIndices = {};

  void _addToExpression(String value, int index) {
    setState(() {
      _currentExpression += value;
      _usedIndices.add(index);
    });
  }

  void _undoLastEntry() {
    setState(() {
      if (_currentExpression.isNotEmpty) {
        String lastChar = _currentExpression.substring(_currentExpression.length - 1);
        int lastIndex = _currentExpression.lastIndexOf(lastChar);
        _currentExpression = _currentExpression.substring(0, _currentExpression.length - 1);
        _usedIndices.remove(lastIndex);
      }
    });
  }

  void _evaluateExpression() {
    try {
      final int result = _simulateExpressionEvaluation(_currentExpression);
      widget.onSubmit(result);
      setState(() {
        _isSubmitted = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid expression')),
      );
    }
  }

  int _simulateExpressionEvaluation(String expression) {
    final random = expression.hashCode;
    return random % 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: _isSubmitted
          ? Container(
              height: 80,
              color: Colors.grey[300],
              child: Center(child: Text('Attempt Submitted')),
            )
          : Padding(
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
                      ...widget.round.numbers.asMap().entries.map((entry) {
                        int index = entry.key;
                        int number = entry.value;
                        return ElevatedButton(
                          onPressed: !_isSubmitted && !_usedIndices.contains(index)
                              ? () => _addToExpression('$number', index)
                              : null,
                          child: Text('$number'),
                        );
                      }),
                      ...['+', '-', '*', '/'].map((operator) => ElevatedButton(
                            onPressed: !_isSubmitted
                                ? () => _addToExpression(operator, -1) // Используем фиктивный индекс
                                : null,
                            child: Text(operator),
                          )),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(onPressed: !_isSubmitted ? _undoLastEntry : null,
                        child: Text('Undo'),
                      ),
                      ElevatedButton(
                        onPressed: !_isSubmitted ? _evaluateExpression : null,
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}