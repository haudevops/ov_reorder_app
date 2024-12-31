import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorder_app/generated/l10n.dart';
import 'package:reorder_app/page/page.dart';
import 'package:reorder_app/routes/route_settings.dart';
import 'utils/providers/language_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageProvider>(
            create: (context) => LanguageProvider()),
      ],
      child: Builder(
          builder: (context) => MaterialApp(
            title: 'REORDER Technology',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor: const Color(0xFF101010),
                appBarTheme: const AppBarTheme(
                    color: Color(0xFF1F1F1F),
                    iconTheme: IconThemeData(color: Colors.white)),
                bottomNavigationBarTheme:
                const BottomNavigationBarThemeData(
                    backgroundColor: Color(0xFF1F1F1F)),
                iconTheme: const IconThemeData(color: Colors.white)),
            locale: Provider.of<LanguageProvider>(context, listen: true)
                .currentLocale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            onGenerateRoute: CustomRouter.allRoutes,
            home: HomeView(),
          )),
    );
  }
}

