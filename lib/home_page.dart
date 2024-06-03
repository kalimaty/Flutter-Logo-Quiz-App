import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quiz_provider.dart';
import 'result_page.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      appBar: AppBar(
        centerTitle: true,
        elevation: 7,
        backgroundColor: Colors.amber.shade100,
        title: Text('Logo Quiz App',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.purple,
              size: 30,
            ),
            onPressed: () {
              context.read<QuizProvider>().resetGame();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.help,
              color: Colors.indigo,
              size: 30,
            ),
            onPressed: () {
              context.read<QuizProvider>().useHint();
            },
          ),
        ],
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          if (quizProvider.isFinished) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(),
                ),
              );
            });
          }

          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                quizProvider.database.isNotEmpty
                    ? Expanded(
                        child: Image.asset(
                            quizProvider.database[quizProvider.index]),
                      )
                    : Container(),
                quizProvider.database.isNotEmpty
                    ? Expanded(
                        flex: 1,
                        child: GridView.builder(
                          itemCount: quizProvider.correctAnswer.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 8,
                          ),
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.black,
                              child: quizProvider.showCorrectAnswerMap[index] ==
                                      true
                                  ? Center(
                                      child: Text(
                                        '${String.fromCharCode(quizProvider.correctAnswerKey[index]!)}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  : Container(),
                            );
                          },
                        ),
                      )
                    : Container(),
                quizProvider.database.isNotEmpty
                    ? Expanded(
                        flex: 1,
                        child: GridView.builder(
                          itemCount: quizProvider.suggest.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 8,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                quizProvider.onAnswerSelected(
                                    index, quizProvider.suggest[index]);
                              },
                              child: Card(
                                color: quizProvider
                                            .showSuggesttAnswerMap[index] ==
                                        -1
                                    ? Colors.blueGrey
                                    : quizProvider
                                                .showSuggesttAnswerMap[index] ==
                                            0
                                        ? Colors.red
                                        : Colors.green,
                                child: Center(
                                  child: quizProvider
                                              .showSuggesttAnswerMap[index] ==
                                          1
                                      ? Icon(Icons.check, color: Colors.white)
                                      : quizProvider.showSuggesttAnswerMap[
                                                  index] ==
                                              0
                                          ? Icon(Icons.clear)
                                          : Text(
                                              '${quizProvider.suggest[index]}',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Container(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed:
                        quizProvider.showCorrectAnswerMap.values.contains(false)
                            ? null
                            : () => quizProvider.startGame(),
                    child: Text('Next', style: TextStyle(fontSize: 25)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
