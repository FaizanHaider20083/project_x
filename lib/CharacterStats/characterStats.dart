import 'package:flutter/material.dart';
import 'dart:math';

class CharacterStats extends StatefulWidget {
  @override
  _CharacterStatsState createState() => _CharacterStatsState();
}

class _CharacterStatsState extends State<CharacterStats> {
  // Initialize stats with random values
  final Random _random = Random();
  int strength = 0;
  late int agility;
  late int intelligence;
  late int social;
  late int endurance;

  @override
  void initState() {
    super.initState();
    strength = _random.nextInt(100);
    agility = _random.nextInt(100);
    intelligence = _random.nextInt(100);
    social = _random.nextInt(100);
    endurance = _random.nextInt(100);
  }

  void _updateStat(String stat, int change) {
    setState(() {
      switch (stat) {
        case 'strength':
          strength += change;
          break;
        case 'agility':
          agility += change;
          break;
        case 'intelligence':
          intelligence += change;
          break;
        case 'social':
          social += change;
          break;
        case 'endurance':
          endurance += change;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Character Stats'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildStatRow('Strength', strength),
            _buildStatRow('Agility', agility),
            _buildStatRow('Intelligence', intelligence),
            _buildStatRow('Social', social),
            _buildStatRow('Endurance', endurance),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String statName, int statValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$statName: $statValue',
            style: TextStyle(fontSize: 18),
          ),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _updateStat(statName.toLowerCase(), 3),
                child: Text('+3'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _updateStat(statName.toLowerCase(), -3),
                child: Text('-3'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
