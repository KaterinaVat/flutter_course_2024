import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game_provider.dart';
import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _playerNameController = TextEditingController();
  List<String> _players = [];
  int _numberOfRounds = 3;

  void _addPlayer() {
    if (_playerNameController.text.isNotEmpty) {
      setState(() {
        _players.add(_playerNameController.text);
        _playerNameController.clear();
      });
    }
  }

  @override
  void dispose() {
    _playerNameController.dispose();
    super.dispose();
  }

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
              'Add Players:',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _playerNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter player name',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addPlayer,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _players.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_players[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _players.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Text(
              'Number of Rounds:',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _numberOfRounds > 1
                      ? () => setState(() {
                          _numberOfRounds--;
                        })
                      : null,
                ),
                Text(
                  _numberOfRounds.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => setState(() {
                    _numberOfRounds++;
                  }),
                ),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _players.isNotEmpty ? () {
                  context
                      .read<GameProvider>()
                      .initializeGame(_players, _numberOfRounds);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GameScreen()),
                  );
                } : null,
                child: Text('Start Game'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}