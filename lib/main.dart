import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home.dart';

import 'firebase_options.dart';
import 'theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, ThemeProvider themeSetting, _) {
          return MaterialApp(
            theme: ThemeData(useMaterial3: true, primarySwatch: Colors.pink),
            darkTheme: ThemeData.dark(useMaterial3: true),
            themeMode: themeSetting.themeMode,
            home: const Home(),
          );
        },
      ),
    );
  }
}
