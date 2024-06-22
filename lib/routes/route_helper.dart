import 'package:get/get.dart';
import 'package:task_remind_offline/pages/database_size_info/db_size_info_page.dart';
import 'package:task_remind_offline/pages/history/history_page.dart';
import 'package:task_remind_offline/pages/home/calendar_page.dart';
import 'package:task_remind_offline/pages/onboarding/onboarding_language_page.dart';
import 'package:task_remind_offline/pages/onboarding/onboarding_page.dart';
import 'package:task_remind_offline/pages/onboarding/onboarding_three.dart';
import 'package:task_remind_offline/pages/onboarding/onboarding_two.dart';
import 'package:task_remind_offline/pages/splash/splash_page.dart';

class RouteHelper {
  //static const _initial = "/";
  static const String _splashPage = "/splash-page";
  static const String _onBoardingLanguagePage = "/onboarding-language-page";
  static const String _onBoardingPage = "/onboarding-page";
  static const String _onBoardingOne = "/onboarding-one";
  static const String _onBoardingTwo = "/onboarding-two";
  static const String _onBoardingThree = "/onboarding-three";
  static const String _calenderPage = "/calender-page";
  static const String _historyPage = "/history-page";
  // ignore: constant_identifier_names
  static const String _DatabaseInfoPage = "/database-info-page";

  // ignore: constant_identifier_names
  static const String _DetailTaskPage = "/detail-task-page";

  // get all route
  //static String getInitial() => _initial;
  static String getSplashPage() => _splashPage;
  // on boarding
  static String getOnBoardingLanguagePage() => _onBoardingLanguagePage;
  static String getOnBoardingPage() => _onBoardingPage;
  static String getOnBoardingOne() => _onBoardingOne;
  static String getOnBoardingTwo() => _onBoardingTwo;
  static String getOnBoardingThree() => _onBoardingThree;
  static String getDatabaseSizeInfoPage() => _DatabaseInfoPage;
  // home
  static String getCalenderPage() => _calenderPage;
  static String getHistoryPage() => _historyPage;
  static String getDetailTaskPage() => _DetailTaskPage;

  static List<GetPage> routes = [
    GetPage(
      name: _splashPage,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: _onBoardingLanguagePage,
      page: () {
        var isHomePage = Get.arguments as bool; // Retrieve the argument
        return OnBoardingLanguagePage(isHomePage: isHomePage);
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: _onBoardingPage,
      page: () => const OnBoardingPage(),
      transition: Transition.fade,
    ),
    // get page on boarding one
    GetPage(
      name: _onBoardingOne,
      page: () => const OnBoardingPageTwo(),
      transition: Transition.fade,
    ),
    // get page on boarding two
    GetPage(
      name: _onBoardingTwo,
      page: () => const OnBoardingPageThree(),
      transition: Transition.fade,
    ),
    // get page on boarding three
    GetPage(
      name: _onBoardingThree,
      page: () => const OnBoardingPageThree(),
      transition: Transition.fade,
    ),
    // calendar page
    GetPage(
      name: _calenderPage,
      page: () => const CalendarPage(),
      transition: Transition.fade,
    ),
    // history page
    GetPage(
      name: _historyPage,
      page: () => const HistoryPage(),
      transition: Transition.fade,
    ),
    // database size info page
    GetPage(
      name: _DatabaseInfoPage,
      page: () => const DatabaseInfoPage(),
      transition: Transition.fade,
    ),
  ];
}
