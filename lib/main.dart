// import 'package:flutter/material.dart';
// import 'app.dart';
// import 'package:provider/provider.dart';
// import 'quiz_provider.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => QuizProvider(),
//       child: MyApp(),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quiz_provider.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizProvider(context),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}



// import 'dart:convert';

// import 'dart:math';

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//   List<String> database = List<String>.empty();
//   int index = -1, clickHint = 0;
//   String correctAnswer = '', suggest = '';
//   Map<int, int> correctAnswerKey = Map();
//   Map<int, int> showSuggesttAnswerMap = Map();
//   Map<int, bool> showCorrectAnswerMap = Map();
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       await addToDataBaseFromAssets();
//       if (database.length > 0) {
//         startGame();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.amber.shade100,
//       key: _scaffoldKey,
//       appBar: AppBar(
//         elevation: 7,
//         backgroundColor: Colors.amber.shade100,
//         title: Center(child: Text('quize app')),
//         actions: [
//           IconButton(
//               icon: Icon(
//                 Icons.refresh,
//                 color: Colors.blue,
//               ),
//               onPressed: () {
//                 startGame();
//               }),
//           IconButton(
//             icon: Icon(
//               Icons.help,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               if (clickHint < 3) {
//                 int hint = 0;
//                 for (var i in showCorrectAnswerMap.entries) {
//                   if (i.value == false) {
//                     showCorrectAnswerMap[i.key] = true;
//                     hint = correctAnswerKey[i.key]!;
//                     break;
//                   }
//                 }
//                 var list = suggest.runes.toList();
//                 for (int i = 0; i < list.length; i++) {
//                   if (list[i] == hint) {
//                     if (showSuggesttAnswerMap[i] != 1) {
//                       showSuggesttAnswerMap[i] = 1;
//                       break;
//                     } else
//                       continue;
//                   }
//                 }
//                 setState(() {
//                   clickHint++;
//                 });
//               } else {
//                 ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
//                   SnackBar(
//                     content: Text(
//                       'you only have 3 times hint',
//                       style: TextStyle(fontSize: 25),
//                     ),
//                   ),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//       body: database.length > 0
//           ? Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 30,
//                   ),
//                   database.length > 0
//                       ? Expanded(
//                           child: Image.asset(database[index]),
//                         )
//                       : Container(),
//                   // correct answer
//                   database.length > 0
//                       ? Expanded(
//                           flex: 1,
//                           child: GridView.builder(
//                             itemCount: correctAnswer.length,
//                             gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 8),
//                             itemBuilder: (context, index) {
//                               return Card(
//                                   color: Colors.black,
//                                   child: showCorrectAnswerMap[index] == true
//                                       ? Center(
//                                           child: Text(
//                                             '${String.fromCharCode(correctAnswerKey[index]!)}',
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         )
//                                       : Container());
//                             },
//                           ),
//                         )
//                       : Container(),
//                   // suggest List

//                   database.length > 0
//                       ? Expanded(
//                           flex: 1,
//                           child: GridView.builder(
//                             itemCount: suggest.length,
//                             gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 8),
//                             itemBuilder: (context, index) {
//                               return GestureDetector(
//                                 onTap: () {
//                                   //button when user choos correct  word
//                                   if (correctAnswer
//                                       .toUpperCase()
//                                       .contains(suggest[index].toUpperCase())) {
//                                     correctAnswerKey.forEach((key, value) {
//                                       if (String.fromCharCode(value)
//                                               .toUpperCase() ==
//                                           suggest[index].toUpperCase())
//                                         setState(() {
//                                           showCorrectAnswerMap[key] = true;
//                                           showSuggesttAnswerMap[index] = 1;
//                                         });
//                                     });
//                                   } else {
//                                     setState(() {
//                                       showSuggesttAnswerMap[index] = 0;
//                                     });
//                                   }
//                                 },
//                                 child: Card(
//                                   color: showSuggesttAnswerMap[index] == -1
//                                       ? Colors.blueGrey
//                                       : showSuggesttAnswerMap[index] == 0
//                                           ? Colors.red
//                                           : Colors.green,
//                                   child: Center(
//                                     //اذا تمت الاجابة قعلا  تظهر علامة الصح
//                                     child: showSuggesttAnswerMap[index] == 1
//                                         ? Icon(
//                                             Icons.check,
//                                             color: Colors.white,
//                                           )
//                                         : showSuggesttAnswerMap[index] == 0
//                                             ? Icon(
//                                                 Icons.clear,
//                                               )
//                                             : Text(
//                                                 // الحروف المقترحة مختلطة بالحروف الصحيحة
//                                                 '${suggest[index]}',
//                                                 style: TextStyle(
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         )
//                       : Container(),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     child: ElevatedButton(
//                         onPressed: showCorrectAnswerMap.values.contains(false)
//                             ? null
//                             : () => startGame(),
//                         child: Text(
//                           'Next',
//                           style: TextStyle(fontSize: 25),
//                         )),
//                   ),
//                 ],
//               ),
//             )
//           : Center(
//               child: CircularProgressIndicator(
//                 backgroundColor: Colors.blue,
//               ),
//             ),
//     );
//   }

//   Future addToDataBaseFromAssets() async {
//     final manifestContent =
//         await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
//     final Map<String, dynamic> manifestMap = json.decode(manifestContent);
//     final imagePaths = manifestMap.keys
//         .where((element) => element.contains("images/"))
//         .where((element) => element.contains(".png"))
//         .toList();
//     setState(() {
//       database = imagePaths;
//     });
//   }

//   void startGame() {
//     //when start new game rest value
//     correctAnswer = suggest = '';
//     showSuggesttAnswerMap.clear();
//     showCorrectAnswerMap.clear();
//     correctAnswerKey = Map();
//     var lastIndex = index;

//     do {
//       index = Random().nextInt(database.length - 1);
//     } while (index == lastIndex);
//     //after have index pic  , we will get name of pic
//     //resul  assets/images<name>.png
//     correctAnswer = database[index]
//         .substring(database[index].lastIndexOf('/') + 1,
//             database[index].lastIndexOf('.'))
//         .toUpperCase();
//     // we need an  suggest String base on correct answer with mixed some charaecter
//     suggest = randomWithAnswer(correctAnswer).toUpperCase();
//     //Base  with correctAnswer we will genrate correcAnswerKey too
//     correctAnswerKey = correctAnswer.runes.toList().asMap();
//     correctAnswerKey.forEach((key, value) {
//       if (key == value) {
//         setState(() {
//           print('f');
//         });
//       }
//       showCorrectAnswerMap.putIfAbsent(key, () => false);

//       //False  - not show
//       //True  -   show
//     });
//     var list = suggest.runes.toList();
//     list.shuffle();
//     list.asMap().forEach((key, value) {
//       //Base on length of list(suggest)
//       //we will init suggest map with:
//       //-1 not Answer
//       //0 wrong Answer
//       //1 Right Answer

//       showSuggesttAnswerMap.putIfAbsent(key, () => -1);
//     });
//     suggest = String.fromCharCodes(list);
//     setState(() {});
//   }

//   String randomWithAnswer(String correctAnswer) {
//     const aToZ = 'abcedfghijklmnopqrstuvwxyz';
//     int orignalLength = correctAnswer.length;
//     var randomeText = "";
//     for (int i = 0; i < orignalLength; i++)
//       randomeText += aToZ[Random().nextInt(aToZ.length)];
//     // remove duplcate from randomeText
//     randomeText = String.fromCharCodes(randomeText.runes.toSet().toList());
//     //contact with correct answer
//     correctAnswer += randomeText;
//     return correctAnswer;
//   }
// }
