import 'package:flutter/material.dart';
import 'package:updater_project/src/components/my_credits_icon_button.dart';
import 'package:updater_project/src/controllers/version_controller_inherited.dart';
import 'package:updater_project/src/pages/home_page_inherited.dart';
import 'package:updater_project/src/repositories/release_local_repository.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final controller = VersionControllerInherited.of(context);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // button to redirec to the my github
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: myCreditsIconButton(),
            ),
          ],
          title: Text('Updater Project ${controller.getVersion()}'),
        ),
        body: const HomePageInherited(),
      ),
    );
  }
}
