import 'package:aza_bank/components/firebase_notification/firebaseNotificationAPI.dart';
import 'package:aza_bank/pages/splash%20screen/splash_screem.dart';
//import 'package:aza_bank/pages/transfer_funds/transferencia_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'theme/aza_bank_theme.dart';
import 'theme/internationalization.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:aza_bank/pages/welcome_page/welcome_page_widget.dart';
import 'package:aza_bank/pages/home_page/home_page_widget.dart';
import 'package:aza_bank/pages/creditos/creditos_widget.dart';
import 'package:aza_bank/pages/search_page/search_page_widget.dart';
import 'package:aza_bank/pages/settingspage/settingspage_widget.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AzaBankTheme.initialize();
  await Firebase.initializeApp();
  await firebaseNotificationAPI().initNotifications();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = AzaBankTheme.themeMode;

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        AzaBankTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AzaBank',
      debugShowCheckedModeBanner: false,
      initialRoute: "splash",
      routes: {
        "splash":(context)=>SplashScreem(),
        "HomePAge":(context)=>HomePageWidget(),
      },
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
      ],
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
      home: FirebaseAuth.instance.currentUser == null? WelcomePageWidget(): NavBarPage(),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);
  final String? initialPage;
  final Widget? page;
  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'HomePage';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  late Widget? _currentPage;

  @override
  void initState() {
   FirebaseAuth.instance.authStateChanges().listen(
        ((User? user){
          if(user == null){
            print("user is currently signed out! ");
          }else{
            print("User is signed in");
          }
        })
    );
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final tabs = {
      'HomePage': HomePageWidget(),
      'Creditos': CreditosWidget(),
      'SearchPage': SearchPageWidget(),
      'Settingspage': SettingspageWidget(),

    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: GNav(
        selectedIndex: currentIndex,
        onTabChange: (i) => setState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: AzaBankTheme.of(context).primary3,
        color: Color(0x8A000000),
        activeColor: AzaBankTheme.of(context).primary,
        tabBackgroundColor: AzaBankTheme.of(context).primary3,
        tabBorderRadius: 100.0,
        tabMargin: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 15.0),
        gap: 3.0,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        duration: Duration(milliseconds: 500),
        haptic: true,
        tabs: [
          GButton(
            icon: Icons.home_outlined,
            text: 'Home',
            iconSize: 24.0,
          ),
          GButton(
            icon: Icons.compare_arrows_rounded,
            text: 'Creditos',
            iconSize: 24.0,
          ),
          GButton(
            icon: Icons.search_rounded,
            text: 'Consejos',
            iconSize: 24.0,
          ),
          GButton(
            icon: Icons.settings_rounded,
            text: 'Configuracion',
            iconSize: 24.0,
          )
        ],
      ),
    );
  }
}
