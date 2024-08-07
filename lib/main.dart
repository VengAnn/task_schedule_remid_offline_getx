import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_remind_offline/routes/route_helper.dart';
import 'package:task_remind_offline/services/databaseHelper/database_helper.dart';
import 'package:task_remind_offline/services/share_preferences.dart';
import 'package:task_remind_offline/translations/app_translate.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

import 'controller/awesome_noti_controller/awesome_noti_controller.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// note: some real device by default close alert on background restricted like redmi... we need open alert permission on the settings that device ....
Future<void> initializeAwesomeNotification() async {
  await AwesomeNotifications().initialize(
    null, // Use the default app icon
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        // Custom sound awesome notificatin
        soundSource: 'resource://raw/res_echo_alert',
        playSound: true,
        //
        enableVibration: true,
        locked: true,
      ),
    ],
  );

  //
  AwesomeNotifications().isNotificationAllowed().then(
    (isAllowed) async {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    },
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeAwesomeNotification();
  // await init_Dependency_Injection(); // initialize the dependencies getx
  await DBHelper.initDb(); // this initialize sqflite
  await SharedPreferencesService.init(); // this SharedPreferences

  String? selectedLanguage = SharedPreferencesService.loadSelectedLanguage();

  if (selectedLanguage == null || selectedLanguage.isEmpty) {
    selectedLanguage = 'en';
  }

  runApp(MyApp(
    selectedLanguage: selectedLanguage,
  ));

  // set for when tap on notification show what page i want to show
  AwesomeNotifications().setListeners(
    onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    onNotificationCreatedMethod:
        NotificationController.onNotificationCreatedMethod,
    onNotificationDisplayedMethod:
        NotificationController.onNotificationDisplayedMethod,
    onDismissActionReceivedMethod:
        NotificationController.onDismissActionReceivedMethod,
  );
}

class MyApp extends StatelessWidget {
  final String? selectedLanguage;

  const MyApp({
    super.key,
    this.selectedLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey, // Use GlobalKey for navigator

      // this custom calendar language with khmer ,vietnamese and english
      // locale: const Locale('km'), // Set default locale to Vietnamese
      locale: Locale(selectedLanguage!), // Use selected language

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('vi'),
        Locale('km'),
      ],
      // end of customite language calendar

      debugShowCheckedModeBanner: false,
      title: 'Note Schedule Reminder Offline',
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white.withOpacity(0.9),
      ),
      translations: AppTranslations(),
      fallbackLocale: const Locale('en'),
      initialRoute: RouteHelper.getSplashPage(),
      getPages: RouteHelper.routes,
    );
  }
}


//
