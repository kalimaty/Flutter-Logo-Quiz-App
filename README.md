# kalimaty

A new Flutter project.



![0](https://github.com/kalimaty/Flutter-Logo-Quiz-App/assets/105967966/3071db09-7c5e-49f7-a55f-f7795a7c2a61)




![1](https://github.com/kalimaty/Flutter-Logo-Quiz-App/assets/105967966/a82d4e08-d51c-4a13-9408-9fdbdf250a13)




وصف برمجي للمشروع: Flutter Logo Quiz App
مكونات المشروع البرمجية

    main.dart
        الوصف: نقطة الدخول الرئيسية للتطبيق.
        المسؤولية: إعداد التطبيق وإدارة التنقل بين الشاشات.

    QuizProvider
        الوصف: مزود الحالة لإدارة بيانات واختبارات الكويز.
        المسؤولية: تحميل البيانات، إدارة الأسئلة، تتبع الإجابات الصحيحة والخاطئة، واستخدام التلميحات.

    QuizWidget
        الوصف: واجهة المستخدم الرئيسية للكويز.
        المسؤولية: عرض الأسئلة، الإجابات المقترحة، التلميحات، والموقت.

    ResultPage
        الوصف: واجهة المستخدم لعرض النتائج بعد الانتهاء من الكويز.
        المسؤولية: عرض عدد الإجابات الصحيحة والخاطئة، النسبة المئوية، وتقديم خيارات لإعادة البدء أو الخروج.

    HistoryWidget
        الوصف: واجهة المستخدم لعرض تاريخ الإجابات.
        المسؤولية: عرض الأسئلة التي تمت الإجابة عليها مع تفاصيل الإجابات.

    TimerWidget
        الوصف: ويدجيت لعرض الموقت التنازلي.
        المسؤولية: عرض عداد تنازلي لكل سؤال وإعادة تعيينه عند الانتقال للسؤال التالي.

متطلبات كل مرحلة برمجية
1. مرحلة الإعداد (Setup Phase)

    تثبيت Flutter و Dart SDK.
    إعداد بيئة التطوير (مثل Android Studio أو VS Code).
    إنشاء مشروع Flutter جديد باستخدام الأمر:

    sh

    flutter create quiz_app

2. مرحلة التصميم (Design Phase)

    تحديد تصميم الواجهات والشاشات المختلفة باستخدام ملفات dart وتنظيمها.
    إنشاء ملف main.dart كنقطة دخول للتطبيق.
    إعداد التنقل بين الشاشات باستخدام Navigator و routes.

3. مرحلة البرمجة (Coding Phase)

    main.dart:
        إعداد MaterialApp وتحديد المسارات.
        إعداد ChangeNotifierProvider لتمرير QuizProvider.

    QuizProvider:
        تحميل قاعدة بيانات الصور.
        إدارة الحالة للأسئلة، الإجابات، التلميحات، وعدد الإجابات الصحيحة والخاطئة.
        دوال للتحكم في الكويز مثل startGame، selectSuggestion، وuseHint.

    QuizWidget:
        عرض الأسئلة والإجابات المقترحة.
        استخدام GridView لعرض الإجابات.
        إضافة مكونات تفاعلية مثل الأزرار والموقت.

    ResultPage:
        عرض النتائج النهائية.
        استخدام Table أو DataTable لعرض النتائج بطريقة منظمة.
        إضافة أزرار لإعادة الكويز أو العودة للشاشة الرئيسية.

    HistoryWidget:
        عرض تاريخ الإجابات باستخدام قائمة.
        عرض تفاصيل كل إجابة مع الوقت المستغرق.

    TimerWidget:
        إنشاء عداد تنازلي لكل سؤال.
        إعادة تعيين الموقت عند الانتقال للسؤال التالي.

4. مرحلة الاختبار (Testing Phase)

    اختبار وحدات التطبيق بشكل منفصل.
    التأكد من عمل المكونات التفاعلية بشكل صحيح.
    اختبار التنقل بين الشاشات والتأكد من عدم وجود مشاكل في إدارة الحالة.

5. مرحلة التحسين والنشر (Enhancement and Deployment Phase)

    تحسين واجهة المستخدم والتأكد من التوافق مع مختلف الأجهزة.
    تحسين أداء التطبيق وتقليل أي تأخير أو مشاكل.
    إعداد التطبيق للنشر على متجر التطبيقات (مثل Google Play أو Apple App Store).
   شجرة المشروع
   
   

 ![2024-06-03_133747](https://github.com/kalimaty/Flutter-Logo-Quiz-App/assets/105967966/ca703d4a-6584-4e2a-952a-b9eeb1a2af05)




الوصف الوظيفي للملفات الأساسية

    main.dart:
        إعداد MaterialApp وتحديد المسارات.
        تضمين QuizProvider كمزود حالة رئيسي.

    quiz_provider.dart:
        إدارة البيانات والحالة لجميع الأسئلة والإجابات.
        تحميل قاعدة بيانات الصور وتحضير الأسئلة.

    quiz_widget.dart:
        عرض السؤال الحالي والإجابات المقترحة.
        التعامل مع التفاعل بين المستخدم والأسئلة.

    result_page.dart:
        عرض النتائج النهائية بعد انتهاء الكويز.
        تقديم خيارات لإعادة البدء أو الخروج.

    history_widget.dart:
        عرض تاريخ الإجابات مع تفاصيل كل إجابة.

    timer_widget.dart:
        عرض موقت تنازلي لكل سؤال.

بهذه الطريقة، يمكن تنظيم المشروع بطريقة هيكلية وواضحة، مما يسهل فهم الأدوار المختلفة لكل جزء ويسهل عملية الصيانة والتطوير المستقبلي.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
