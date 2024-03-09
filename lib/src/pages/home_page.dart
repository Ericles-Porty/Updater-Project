// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:updater_project/src/core/updater.dart';
// import 'package:updater_project/src/controllers/version_controller.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key, required this.versionController});

//   final VersionController versionController;
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool isDownloading = false;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: double.infinity,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               !isDownloading
//                   ? ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(Colors.green),
//                       ),
//                       onPressed: () async {
//                         setState(() {
//                           isDownloading = true;
//                         });
//                         await Updater.checkForUpdates();
//                         setState(() {
//                           isDownloading = false;
//                         });
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Update checked'),
//                             backgroundColor: Colors.green,
//                           ),
//                         );
//                         final localReleaseVersion = await Updater.getLocalReleaseVersion();
//                         widget.versionController.setVersion(localReleaseVersion ?? '0.0');
//                       },
//                       child: const Text('Check for updates'),
//                     )
//                   : const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//               ElevatedButton(
//                 onPressed: () async {
//                   final localReleaseVersion = await Updater.getAllReleaseVersions();
//                   showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                             content: Center(
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     width: MediaQuery.of(context).size.width * 0.8,
//                                     height: MediaQuery.of(context).size.height * 0.1,
//                                     child: Center(child: Text('Select a version to set as local release version:')),
//                                   ),
//                                   Expanded(
//                                     child: Center(
//                                       child: SingleChildScrollView(
//                                         scrollDirection: Axis.vertical,
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//                                             for (var version in localReleaseVersion)
//                                               TextButton(
//                                                   onPressed: () {
//                                                     widget.versionController.setVersion(version);
//                                                     Navigator.pop(context);
//                                                   },
//                                                   child: Text(version)),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ));

//                   // ScaffoldMessenger.of(context).showSnackBar(
//                   //   SnackBar(
//                   //     content: Text('All release versions: $localReleaseVersion'),
//                   //   ),
//                   // );
//                 },
//                 child: const Text('Get all release versions'),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   await Updater.setLocalReleaseVersion('0.0');
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Local release version reset'),
//                     ),
//                   );
//                   widget.versionController.setVersion('0.0');
//                 },
//                 child: const Text('Reset local release version'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
