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

class MyAppInherited extends StatelessWidget {
  const MyAppInherited({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: myBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: myAppBar(context),
          body: const HomePageInherited(),
        ),
      ),
    );
  }
}
