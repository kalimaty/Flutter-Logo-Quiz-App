import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class QuizProvider with ChangeNotifier {
  QuizProvider(BuildContext context) {
    _initTts();
    loadDatabase(context);
  }

  List<int> answeredQuestions = [];
  List<String> history = [];
  String correctAnswer = '', suggest = '';
  Map<int, int> correctAnswerKey = {};
  int correctCount = 0;
  List<String> database = [];
  FlutterTts flutterTts = FlutterTts();
  int index = -1;
  bool isFinished = false;
  Map<int, bool> showCorrectAnswerMap = {};
  Map<int, int> showSuggesttAnswerMap = {};
  int wrongCount = 0;

  Future<void> loadDatabase(BuildContext context) async {
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final imagePaths = manifestMap.keys
        .where((element) => element.contains("images/"))
        .where((element) => element.contains(".png"))
        .toList();
    database = imagePaths;
    startGame();
  }

  // void startGame() {
  //   if (database.isEmpty) return;
  //   resetValues();

  //   if (answeredQuestions.length == database.length) {
  //     isFinished = true;
  //     notifyListeners();
  //     return;
  //   }

  //   do {
  //     index = Random().nextInt(database.length);
  //   } while (answeredQuestions.contains(index));

  //   correctAnswer = database[index]
  //       .substring(database[index].lastIndexOf('/') + 1,
  //           database[index].lastIndexOf('.'))
  //       .toUpperCase();
  //   suggest = randomWithAnswer(correctAnswer).toUpperCase();
  //   correctAnswerKey = correctAnswer.runes.toList().asMap();
  //   correctAnswerKey.forEach((key, value) {
  //     showCorrectAnswerMap[key] = false;
  //   });
  //   suggest.runes.toList().asMap().forEach((key, value) {
  //     showSuggesttAnswerMap[key] = -1;
  //   });
  //   answeredQuestions.add(index);
  //   isFinished = false;
  //   notifyListeners();
  //   _speak(correctAnswer);
  // }
void startGame() {
    if (database.isEmpty) return;
    resetValues();

    if (answeredQuestions.length == database.length) {
      isFinished = true;
      notifyListeners();
      return;
    }

    do {
      index = Random().nextInt(database.length);
    } while (answeredQuestions.contains(index));

    correctAnswer = database[index]
        .substring(database[index].lastIndexOf('/') + 1,
            database[index].lastIndexOf('.'))
        .toUpperCase();
    suggest = randomWithAnswer(correctAnswer);
    correctAnswerKey = correctAnswer.runes.toList().asMap();
    correctAnswerKey.forEach((key, value) {
      showCorrectAnswerMap[key] = false;
    });
    suggest.runes.toList().asMap().forEach((key, value) {
      showSuggesttAnswerMap[key] = -1;
    });
    answeredQuestions.add(index);
    isFinished = false;
    notifyListeners();
    _speak(correctAnswer);
  }

  void resetValues() {
    correctAnswer = '';
    suggest = '';
    showCorrectAnswerMap.clear();
    showSuggesttAnswerMap.clear();
  }

  void resetGame() {
    correctCount = 0;
    wrongCount = 0;
    answeredQuestions.clear();
    startGame();
  }

  // String randomWithAnswer(String correctAnswer) {
  //   const aToZ = 'abcdefghijklmnopqrstuvwxyz';
  //   int originalLength = correctAnswer.length;
  //   var randomText = "";
  //   for (int i = 0; i < originalLength; i++) {
  //     randomText += aToZ[Random().nextInt(aToZ.length)];
  //   }
  //   randomText = String.fromCharCodes(randomText.runes.toSet().toList());
  //   var combinedText = correctAnswer + randomText;
  //   var shuffledText = combinedText.runes.toList()..shuffle();
  //   return String.fromCharCodes(shuffledText);
  // }
String randomWithAnswer(String correctAnswer) {
    const aToZ = 'abcdefghijklmnopqrstuvwxyz';
    int originalLength = correctAnswer.length;
    Set<String> randomSet = {};

    // Ensure randomSet has unique letters
    while (randomSet.length < originalLength) {
      randomSet.add(aToZ[Random().nextInt(aToZ.length)]);
    }

    // Convert Set to List and shuffle
    List<String> randomList = randomSet.toList();
    randomList.shuffle();

    // Convert correctAnswer to Set to ensure unique letters
    Set<String> correctAnswerSet = correctAnswer.split('').toSet();

    // Combine both sets
    List<String> combinedList = [...correctAnswerSet, ...randomList];

    // Ensure the combined list has unique letters and shuffle again
    combinedList = combinedList.toSet().toList();
    combinedList.shuffle();

    return combinedList.join().toUpperCase();
  }

  void onAnswerSelected(int index, String letter) {
    if (correctAnswer.toUpperCase().contains(letter.toUpperCase())) {
      correctAnswerKey.forEach((key, value) {
        if (String.fromCharCode(value).toUpperCase() == letter.toUpperCase()) {
          showCorrectAnswerMap[key] = true;
          showSuggesttAnswerMap[index] = 1;
        }
      });
      correctCount++;
    } else {
      showSuggesttAnswerMap[index] = 0;
      wrongCount++;
    }
    notifyListeners();
  }

  void useHint() {
    int hint = 0;
    for (var entry in showCorrectAnswerMap.entries) {
      if (!entry.value) {
        showCorrectAnswerMap[entry.key] = true;
        hint = correctAnswerKey[entry.key]!;
        break;
      }
    }
    var list = suggest.runes.toList();
    for (int i = 0; i < list.length; i++) {
      if (list[i] == hint && showSuggesttAnswerMap[i] != 1) {
        showSuggesttAnswerMap[i] = 1;
        break;
      }
    }
    notifyListeners();
  }

  void _initTts() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }
}
