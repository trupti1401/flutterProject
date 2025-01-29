import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(DiceGameApp());
}

class DiceGameApp extends StatelessWidget {
  const DiceGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DiceGameScreen(),
    );
  }
}

class DiceGameScreen extends StatefulWidget {
  const DiceGameScreen({super.key});

  @override
  _DiceGameScreenState createState() => _DiceGameScreenState();
}

class _DiceGameScreenState extends State<DiceGameScreen> {
  int player1Score = 0;
  int player2Score = 0;
  int player1Roll = 1;
  int player2Roll = 1;
  String resultMessage = "Let's Play!";

  final Random random = Random();

  void rollDice() {
    setState(() {
      player1Roll = random.nextInt(6) + 1; // Dice roll for Player 1 (1-6)
      player2Roll = random.nextInt(6) + 1; // Dice roll for Player 2 (1-6)

      if (player1Roll > player2Roll) {
        player1Score++;
        resultMessage = "Player 1 Wins this round!";
      } else if (player1Roll < player2Roll) {
        player2Score++;
        resultMessage = "Player 2 Wins this round!";
      } else {
        resultMessage = "It's a Draw!";
      }
    });
  }

  void resetGame() {
    setState(() {
      player1Score = 0;
      player2Score = 0;
      player1Roll = 1;
      player2Roll = 1;
      resultMessage = "Game Reset. Let's Play!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multiplayer Dice Game"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Multiplayer Dice Game",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPlayerColumn("Player 1", player1Roll, player1Score),
              _buildPlayerColumn("Player 2", player2Roll, player2Score),
            ],
          ),
          SizedBox(height: 20),
          Text(
            resultMessage,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: rollDice,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: Text("Roll Dice"),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: resetGame,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: Text("Reset Game"),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerColumn(String playerName, int roll, int score) {
    return Column(
      children: [
        Text(
          playerName,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Image.asset(
          'assets/dice$roll.jpg', // Ensure dice images are added in assets
          height: 100,
          width: 100,
        ),
        SizedBox(height: 10),
        Text(
          "Score: $score",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
