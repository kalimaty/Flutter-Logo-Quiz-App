import 'package:flutter/material.dart';
import 'package:kalimaty/home_page.dart';
import 'package:provider/provider.dart';
import 'quiz_provider.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();
    final correctCount = quizProvider.correctCount;
    final wrongCount = quizProvider.wrongCount;
    final totalCount = correctCount + wrongCount;
    final percentage = totalCount > 0 ? (correctCount / totalCount) * 100 : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Quiz Results',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              DataTable(
                border: TableBorder.all(color: Colors.green, width: 2),
                columns: [
                  DataColumn(
                    label: Text(
                      'Metric',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Value',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text(
                      'Correct Answers',
                      style: TextStyle(fontSize: 18),
                    )),
                    DataCell(Text(
                      '$correctCount',
                      style: TextStyle(fontSize: 18),
                    )),
                  ]),
                  DataRow(cells: [
                    DataCell(Text(
                      'Wrong Answers',
                      style: TextStyle(fontSize: 18),
                    )),
                    DataCell(Text(
                      '$wrongCount',
                      style: TextStyle(fontSize: 18),
                    )),
                  ]),
                  DataRow(cells: [
                    DataCell(Text(
                      'Percentage',
                      style: TextStyle(fontSize: 18),
                    )),
                    DataCell(Text(
                      '${percentage.toStringAsFixed(2)}%',
                      style: TextStyle(fontSize: 18),
                    )),
                  ]),
                ],
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  quizProvider.resetGame();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
                child: Text(
                  'Restart Quiz',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
