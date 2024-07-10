import 'package:flutter/material.dart';

void main() => runApp(OmokGameApp());

class OmokGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Omok Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OmokGame(),
    );
  }
}

class OmokGame extends StatefulWidget {
  @override
  _OmokGameState createState() => _OmokGameState();
}

class _OmokGameState extends State<OmokGame> {
  late List<List<int>> board;
  late bool isBlackTurn;

  @override
  void initState() {
    super.initState();
    initializeBoard();
  }

  void initializeBoard() {
    board = List.generate(15, (_) => List.generate(15, (_) => 0));
    isBlackTurn = true;
  }

  void dropStone(int row, int col) {
    if (board[row][col] == 0) {
      setState(() {
        board[row][col] = isBlackTurn ? 1 : 2;
        isBlackTurn = !isBlackTurn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Omok Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              isBlackTurn ? "Black's Turn" : "White's Turn",
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              width: 300,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 15,
                ),
                itemBuilder: (BuildContext context, int index) {
                  int row = index ~/ 15;
                  int col = index % 15;
                  return GestureDetector(
                    onTap: () => dropStone(row, col),
                    child: Container(
                      //color: Colors.grey[300],
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: board[row][col] == 0
                            ? null
                            : board[row][col] == 1
                                ? const CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 15,
                                  )
                                : const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 15,
                                  ),
                      ),
                    ),
                  );
                },
                itemCount: 15 * 15,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  initializeBoard();
                });
              },
              child: const Text('Reset Game'),
            ),
          ],
        ),
      ),
    );
  }
}
