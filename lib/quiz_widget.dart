import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quiz_provider.dart';
import 'result_page.dart';

class QuizWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var quizProvider = context.watch<QuizProvider>();

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Expanded(
            child: Image.asset(quizProvider.database[quizProvider.index]),
          ),
          Expanded(
            flex: 1,
            child: GridView.builder(
              itemCount: quizProvider.correctAnswer.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.black,
                  child: quizProvider.showCorrectAnswerMap[index] == true
                      ? Center(
                          child: Text(
                            '${String.fromCharCode(quizProvider.correctAnswerKey[index]!)}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Container(),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: GridView.builder(
              itemCount: quizProvider.suggest.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    quizProvider.onAnswerSelected(
                        index, quizProvider.suggest[index]);
                    if (quizProvider.showSuggesttAnswerMap[index] == 1) {
                      quizProvider.correctCount++;
                    } else if (quizProvider.showSuggesttAnswerMap[index] == 0) {
                      quizProvider.wrongCount++;
                    }
                  },
                  child: Card(
                    color: quizProvider.showSuggesttAnswerMap[index] == -1
                        ? Colors.blueGrey
                        : quizProvider.showSuggesttAnswerMap[index] == 0
                            ? Colors.red
                            : Colors.green,
                    child: Center(
                      child: quizProvider.showSuggesttAnswerMap[index] == 1
                          ? Icon(Icons.check, color: Colors.white)
                          : quizProvider.showSuggesttAnswerMap[index] == 0
                              ? Icon(Icons.clear)
                              : Text(
                                  '${quizProvider.suggest[index]}',
                                  style: TextStyle(color: Colors.white),
                                ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed:
                  quizProvider.showCorrectAnswerMap.values.contains(false)
                      ? null
                      : () {
                          if (quizProvider.isFinished) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultPage(),
                              ),
                            );
                          } else {
                            quizProvider.startGame();
                          }
                        },
              child: Text(
                'Next',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
