import 'package:flutter/material.dart';
import 'package:updater_project/src/components/my_app_bar.dart';
import 'package:updater_project/src/components/my_background.dart';
import 'package:updater_project/src/controllers/version_controller_inherited.dart';
import 'package:updater_project/src/pages/home_page_inherited.dart';
import 'package:updater_project/src/repositories/release_local_repository.dart';

void main() async {
  final String appVersion = await ReleaseLocalRepository.getLocalReleaseVersion() ?? '';
  runApp(
    VersionControllerInherited(
      version: appVersion,
      child: const MyAppInherited(),
    ),
  );
}

class MyAppInherited extends StatefulWidget {
  const MyAppInherited({super.key});

  @override
  State<MyAppInherited> createState() => _MyAppInheritedState();
}

class _MyAppInheritedState extends State<MyAppInherited> {
  bool isDarkMode = true;
  @override
  Widget build(BuildContext context) {
    final myBackground = isDarkMode ? myBackgroundDark : myBackgroundLight;
    final themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      home: myBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: myAppBar(context)
            ..actions?.add(
              Switch(
                value: isDarkMode,
                onChanged: (value) => setState(() => isDarkMode = value),
              ),
            ),
          body: const HomePageInherited(),
        ),
      ),
    );
  }
}
