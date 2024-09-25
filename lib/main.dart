import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todolati2024/providers/dark_mode_provider.dart';
import 'package:todolati2024/providers/localization_provider.dart';
import 'package:todolati2024/providers/tasks_provider.dart';
import 'package:todolati2024/screens/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TasksProvider>(
            create: (context) => TasksProvider()..getTasks()),
        ChangeNotifierProvider<DarkModeProvider>(
            create: (context) => DarkModeProvider()..getMode()),
        ChangeNotifierProvider<LocalizationProvider>(
            create: (context) => LocalizationProvider()..getLanguage())
      ],
      child: Consumer2<DarkModeProvider, LocalizationProvider>(
          builder: (context, darkModeConsumer, localizationConsumer, _) {
        return MaterialApp(
          locale: Locale(localizationConsumer.language),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
            Locale('es'),
          ],
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            dividerTheme: DividerThemeData(
              color: darkModeConsumer.isDark ? Colors.white24 : Colors.black26,
            ),
            tabBarTheme: TabBarTheme(
                labelColor:
                    darkModeConsumer.isDark ? Colors.white : Colors.blueGrey),
            appBarTheme: const AppBarTheme(
                centerTitle: true, backgroundColor: Colors.blue),
            drawerTheme: DrawerThemeData(
                backgroundColor:
                    darkModeConsumer.isDark ? Colors.black : Colors.white),
            scaffoldBackgroundColor:
                darkModeConsumer.isDark ? Colors.black : Colors.white,
            textTheme: GoogleFonts.cairoTextTheme(),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: false,
          ),
          home: const HomeScreen(),
        );
      }),
    );
  }
}
