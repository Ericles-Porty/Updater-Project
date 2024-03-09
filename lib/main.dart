import 'package:flutter/material.dart';
import 'package:updater_project/src/controllers/version_controller_inherited.dart';
import 'package:updater_project/src/pages/home_page_inherited.dart';

void main() {
  runApp(
    VersionControllerInherited(
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
      home: Scaffold(
        appBar: AppBar(
          title: Text('Updater Project ${controller.getVersion()}'),
        ),
        body: const HomePageInherited(),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   final VersionController versionController = VersionController();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: ValueListenableBuilder(
//             valueListenable: versionController,
//             builder: (BuildContext context, String value, Widget? child) {
//               return Text('Updater Project - v$value');
//             },
//           ),
//         ),
//         body: HomePage(versionController: versionController),
//       ),
//     );
//   }
// }
