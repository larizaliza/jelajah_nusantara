import 'package:flutter/material.dart';

import 'data/destination_repository.dart';
import 'screens/main_shell.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

void main() => runApp(const JelajahNusantaraApp());

class JelajahNusantaraApp extends StatefulWidget {
  const JelajahNusantaraApp({super.key});

  @override
  State<JelajahNusantaraApp> createState() => _JelajahNusantaraAppState();
}

class _JelajahNusantaraAppState extends State<JelajahNusantaraApp> {
  late final AppState _appState = AppState(DestinationRepository())..load();

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: _appState,
      child: MaterialApp(
        title: 'Jelajah Nusantara',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const MainShell(),
      ),
    );
  }
}
