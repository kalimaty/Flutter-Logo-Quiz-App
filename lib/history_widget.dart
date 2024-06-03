import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'quiz_provider.dart';

class HistoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var quizProvider = context.watch<QuizProvider>();

    return DataTable(
      columns: [
        DataColumn(label: Text('Word')),
        DataColumn(label: Text('Image')),
        DataColumn(label: Text('Audio')),
      ],
      rows: quizProvider.database
          .map(
            (e) => DataRow(
              cells: [
                DataCell(Text(e)),
                DataCell(Image.asset(e)),
                DataCell(IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {
                    quizProvider.flutterTts.speak(e);
                  },
                )),
              ],
            ),
          )
          .toList(),
    );
  }
}


/**
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import 'quiz_provider.dart';

class HistoryWidget extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    var quizProvider = context.watch<QuizProvider>();
    return ListView.builder(
      itemCount: quizProvider.history.length,
      itemBuilder: (context, index) {
        String imagePath = quizProvider.history[index];
        String imageName = imagePath
            .substring(
                imagePath.lastIndexOf('/') + 1, imagePath.lastIndexOf('.'))
            .toUpperCase();

        return ListTile(
          leading: Image.asset(imagePath),
          title: Text(imageName),
          onTap: () async {
            await flutterTts.setLanguage('en-US');
            await flutterTts.speak(imageName);
          },
        );
      },
    );
  }
}

 */