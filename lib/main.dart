import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'theme/aza_bank_theme.dart';
import 'theme/internationalization.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:aza_bank/pages/welcome_page/welcome_page_widget.dart';
import 'package:aza_bank/pages/home_page/home_page_widget.dart';
import 'package:aza_bank/pages/transfer_funds/transfer_funds_widget.dart';
import 'package:aza_bank/pages/search_page/search_page_widget.dart';
import 'package:aza_bank/pages/settingspage/settingspage_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AzaBankTheme.initialize();

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
      home: WelcomePageWidget(),
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
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'HomePage': HomePageWidget(),
      'TransferFunds': TransferFundsWidget(),
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
            text: 'Transfer',
            iconSize: 24.0,
          ),
          GButton(
            icon: Icons.search_rounded,
            text: 'Search',
            iconSize: 24.0,
          ),
          GButton(
            icon: Icons.settings_rounded,
            text: 'Settings',
            iconSize: 24.0,
          )
        ],
      ),
    );
  }
}
