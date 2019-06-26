import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' as schedule;
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nemob_cs_helper/application.dart';
import 'package:nemob_cs_helper/pages/home/home_container.dart';
import 'package:nemob_cs_helper/utilities/global.dart' as global;
import 'package:nemob_cs_helper/utilities/global.dart';
import 'package:nemob_cs_helper/utilities/localization.dart';
import 'package:nemob_cs_helper/utilities/pref_keys.dart';
import 'package:pit_components/components/adv_button.dart';
import 'package:pit_components/components/adv_column.dart';
import 'package:pit_components/components/adv_future_builder.dart';
import 'package:pit_components/components/adv_state.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new CsHelperApp());
  });

//  // Define a test. The TestWidgets function will also provide a WidgetTester
//  // for us to work with. The WidgetTester will allow us to build and interact
//  // with Widgets in the test environment.
//  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
//    // Create the Widget tell the tester to build it
//    await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));
//
//    // Create our Finders
//    final titleFinder = find.text('T');
//    final messageFinder = find.text('M');
//
//    // Use the `findsOneWidget` matcher provided by flutter_test to verify our
//    // Text Widgets appear exactly once in the Widget tree
//    expect(titleFinder, findsOneWidget);
//    expect(messageFinder, findsOneWidget);
//  });
}

class CsHelperApp extends StatefulWidget {
  @override
  _CsHelperAppState createState() => new _CsHelperAppState();
}

class _CsHelperAppState extends AdvState<CsHelperApp> {
  Locale _locale = Locale("en");
  Widget _widget = HomeContainerPage();

//  SharedPreferences prefs;
  bool loadAllFinal = false;

//  bool isMinVer = false;
//  bool isLatestVer = false;

//  String checKMinVer;
//  String checkLatestVer;

  Future<bool> getPrefs(BuildContext context) async {
//    prefs ??= await SharedPreferences.getInstance();

//    PitComponents.buttonBackgroundColor = CompanyColors.accent[500];
//    PitComponents.buttonTextColor = CompanyColors.primary[500];
//
//    PitComponents.textFieldHintColor = Colors.black26;
//    PitComponents.textFieldLabelColor = Colors.black;
//    PitComponents.radioButtonTitleColor = Color(0xffB0B0B0);
//    PitComponents.radioButtonColor = global.systemAccentColor;
//    PitComponents.textFieldButtonColor = global.systemAccentColor;
//    PitComponents.groupCheckCheckColor = global.systemAccentColor;
//    PitComponents.textFieldButtonColor = global.systemAccentColor;
//    PitComponents.datePickerIconPrevious = Icons.arrow_back;
//    PitComponents.datePickerIconNext = Icons.arrow_forward;
//    PitComponents.datePickerIconColor = Colors.black;
//
//    PitComponents.datePickerDaysLabelColor = Colors.black;
//    PitComponents.datePickerTodayTextColor = Colors.black;
//    PitComponents.datePickerTodayColor = Color.lerp(global.systemAccentColor, Colors.white, 0.7);
//    PitComponents.datePickerSelectedColor = global.systemAccentColor;
//    PitComponents.datePickerSelectedTextColor = Color(0xff000000);
//
//    PitComponents.datePickerWeekendColor = global.systemRedColor;
//    PitComponents.datePickerToolbarColor = Color(0xffffffff);
//    PitComponents.datePickerHeaderColor = Colors.black;
//    AdvImagePicker.primaryColor = global.systemAccentColor;
//    AdvImagePicker.loadingAssetName = Assets.nemobLoading;
//
//    PitComponents.loadingBarrierColor = Colors.black.withOpacity(0.82);
//    PitComponents.loadingHeight = 30.0;
//    PitComponents.loadingWidth = 30.0;
//
//    PitComponents.datePickerMarkedDaysDaysColor = Colors.black;

//    checKMinVer = await APIRequest.getMinVersion(context);
//    if (checKMinVer != null) isMinVer = await _checkVersion(checKMinVer);
//
//    checkLatestVer = await APIRequest.getLatestVersion(context);
//    if (checkLatestVer != null) isLatestVer = await _checkVersion(checkLatestVer);

    loadAllFinal =
        true; //localchanged bs kepanggil kapanpun, ini flag yg menandakan bahwa load all uda dikerjakan semua
    return true;
  }

//  Future<bool> _checkVersion(String checkAppVersion) async {
//    int firstString = checkAppVersion.indexOf("+") + 1;
//    int versionFromServer = int.tryParse(
//        checkAppVersion.substring(firstString, checkAppVersion.length));
//    PackageInfo packageInfo = await PackageInfo.fromPlatform();
//    int versionFromLocal = int.tryParse(packageInfo.buildNumber);
//
//    print("Version From Server : $versionFromServer");
//    print("Version From Local : $versionFromLocal");
//    if (versionFromLocal >= versionFromServer) {
//      return true;
//    } else {
//      return false;
//    }
//  }

  @override
  void initState() {
    super.initState();
    application.onLocaleChanged = onLocaleChange;
//    application.flavor = flavorDev; //flavorDev
  }

  @override
  Widget advBuild(BuildContext context) {
//    schedule.timeDilation = 7.0;
//    _retrieveDynamicLink();
    return AdvFutureBuilder(
      futureExecutor: getPrefs,
      widgetBuilder: (BuildContext context) {
        bool isDataMasterNull = false; //(checKMinVer == null || checkLatestVer == null);

        if (loadAllFinal /*&& prefs != null*/) {
//          final String localeString = (prefs.getString(kLocale) ?? "id");
//          _locale = Locale(localeString);
//          _widget =
//          (prefs.getString(global.userId) ?? "") == "" ? WelcomePage() : HomeContainerPage();
          _widget = HomeContainerPage();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              CsHelperLocalizationsDelegate(overriddenLocale: _locale),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', 'US'), // English
              const Locale('id', 'ID'), // Hebrew
            ],
            theme: new ThemeData(
                brightness: Brightness.light,
                primarySwatch: CompanyColors.primary,
                primaryColor: CompanyColors.primary[0],
                primaryColorBrightness: Brightness.light,
                accentColor: CompanyColors.accent[500],
                scaffoldBackgroundColor: CompanyColors.primary[0],
                fontFamily: "Roboto",
                accentColorBrightness: Brightness.light),
            home: isDataMasterNull
                ? Builder(builder: (BuildContext context) {
                    return _errorHandler(context);
                  })
                : NHome(_widget)
//                : (!isMinVer || !isLatestVer)
//                    ? Builder(builder: (BuildContext context) {
//                        return _checkMinVersion(context);
//                      })
//                    : NHome(_widget),
          );
        } else {
          return MaterialApp(
            home: Scaffold(
                backgroundColor: Color(0xfffcbf12),
                body: Center(
                    child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.black)))),
          );
        }
      },
    );
  }

  Widget _checkMinVersion(BuildContext context) {
    CsHelperDict dict = CsHelperDict.of(context);
//    if (!isMinVer) {
//      return Scaffold(
//          backgroundColor: Color(0xfffcbf12),
//          body: Center(
//              child: AdvColumn(
//                divider: ColumnDivider(8.0),
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  Container(
//                      padding: EdgeInsets.symmetric(horizontal: 32.0),
//                      child: Text(dict.getString('force_update_info'), textAlign: TextAlign.center, style: ts.fs16)),
//                  AdvButton(
//                    dict.getString('update'),
//                    onPressed: () {
//                      SingleShareHelper.updateApps(context);
//                    },
//                    onlyBorder: true,
//                    textColor: Colors.white,
//                    backgroundColor: global.systemRedColor,
//                  )
//                ],
//              )));
//    } else if (!isLatestVer) {
//      return Scaffold(
//          backgroundColor: Color(0xfffcbf12),
//          body: Center(
//              child: AdvColumn(
//                divider: ColumnDivider(8.0),
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  Container(
//                      padding: EdgeInsets.symmetric(horizontal: 32.0),
//                      child: Text(dict.getString('soft_update_info'), textAlign: TextAlign.center, style: ts.fs16)),
//                  AdvButton(
//                    dict.getString('ok'),
//                    padding: EdgeInsets.symmetric(horizontal: 16.0),
//                    onPressed: () {
//                      setState(() {
//                        isLatestVer = true;
//                      });
//                    },
//                    onlyBorder: true,
//                    textColor: Colors.white,
//                    backgroundColor: global.systemGreenColor,
//                  )
//                ],
//              )));
//    }
  }

  Widget _errorHandler(BuildContext context) {
    CsHelperDict dict = CsHelperDict.of(context);

    return Scaffold(
        backgroundColor: Color(0xfffcbf12),
        body: Center(
            child: AdvColumn(
          divider: ColumnDivider(8.0),
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(dict.getString('failed_to_retrieve_data')),
            AdvButton(
              dict.getString('retry'),
              onPressed: () {
                setState(() {
//                      remote.reset();
                });
              },
              onlyBorder: true,
              textColor: Colors.white,
              backgroundColor: Colors.black,
            )
          ],
        )));
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
}

class NHome extends StatefulWidget {
  final Widget home;
  final String userId;

  NHome(this.home, {this.userId});

  @override
  _NHomeState createState() => _NHomeState();
}

class _NHomeState extends AdvState<NHome> with WidgetsBindingObserver {
  Timer _timerLink;

  @override
  void didUpdateWidget(NHome oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void initStateWithContext(BuildContext context) {
    super.initStateWithContext(context);
//    _retrieveDynamicLink();
    WidgetsBinding.instance.addObserver(this);

//    if (widget.getToken) NotificationHelper.getToken();

//    NotificationHelper.init(
//      onMessage: (Map<String, dynamic> message) async {
//        print("onMessage fired! => $message");
//
//        var data = Platform.isIOS ? message : message["data"];
//        var bigTextStyleInformation =
//        new BigTextStyleInformation(data["message"], htmlFormatSummaryText: true);
//        var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//            kNotificationChannelId, kNotificationChannelName, kNotificationChannelDesc,
//            importance: Importance.Max,
//            priority: Priority.High,
//            color: Color(0xfffcbf12),
//            style: AndroidNotificationStyle.BigText,
//            styleInformation: bigTextStyleInformation);
//        var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//        var platformChannelSpecifics =
//        new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//        await FlutterLocalNotificationsPlugin().show(NotificationHelper.getNotificationId(),
//            "Nemob", data["message"], platformChannelSpecifics,
//            payload: data.toString());
//      },
//      onLaunch: (Map<String, dynamic> message) {
//        print("onLaunch fired! => $message");
//      },
//      onResume: (Map<String, dynamic> message) {
//        print("onResume fired! => $message");
//      },
//      onTokenRefresh: (String token) {
//        print("onTokenRefresh fired! => ${token}, ${widget.userId}");
//        if (widget.userId != null) {
//          APIRequest.postDeviceType(context, firebaseToken: token).then((registered) {
//            if (!registered) {
//              AccountHelper.signOut().then((_) {
//                Routing.pushAndRemoveUntil(context, WelcomePage(), (route) => false);
//              });
//            }
//          });
//        }
//      },
//    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
//    if (state == AppLifecycleState.resumed) {
//      _timerLink = new Timer(const Duration(milliseconds: 850), () {
//        _retrieveDynamicLink();
//      });
//    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timerLink?.cancel();

    super.dispose();
  }

//  Future<void> _retrieveDynamicLink() async {
//    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.retrieveDynamicLink();
//    final Uri deepLink = data?.link;
//
//    if (deepLink == null) return;
//
//    print("data => $data");
//    print("deepLink => $deepLink");
//    print("deepLink 1 => ${deepLink.path}");
//    print("deepLink 1 => ${deepLink.scheme}");
//    print("deepLink 1 => ${deepLink.query}");
//    print("deepLink 1 => ${deepLink.pathSegments}");
//    print("deepLink 1 => ${deepLink.queryParameters}");
//    print("deepLink 1 => ${deepLink.origin}");
//    print("deepLink 1 => ${deepLink.authority}");
//    print("deepLink 1 => ${deepLink.host}");
//    print("deepLink 1 => ${deepLink.userInfo}");
//    print("deepLink 1 => ${deepLink.data}");
//
//    if (deepLink.pathSegments.length == 3 && deepLink.pathSegments[1] == "self-drive-detail") {
//      DynamicLinksHelper.directToSelfDrive(context, deepLink.queryParameters);
//    } else if (deepLink.pathSegments.length == 3 && deepLink.pathSegments[1] == "search-detail") {
//      DynamicLinksHelper.goToRent(context, deepLink.queryParameters);
//    } else if (deepLink.pathSegments.length == 2 && deepLink.pathSegments[1] == "register") {
//      DynamicLinksHelper.goToRegister(context, deepLink.queryParameters);
//    } else if (deepLink.pathSegments.length == 1 && deepLink.pathSegments[0] == "change-password") {
//      DynamicLinksHelper.goToResetPassword(context, deepLink.queryParameters);
//    }
//  }

  @override
  Widget advBuild(BuildContext context) {
//    return Column(children: [Text(widget.data ?? "Data Null"), Text(widget.deepLink ?? "Deep Link Null")]);
    return widget.home;
  }
}
