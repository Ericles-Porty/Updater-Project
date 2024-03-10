import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const String _myGithubProfileUrl = 'https://github.com/Ericles-Porty/Updater-Project';

IconButton myCreditsIconButton() {
  Uri url = Uri.parse(_myGithubProfileUrl);
  return IconButton(
    iconSize: 40,
    icon: const Icon(Icons.link),
    onPressed: () async {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    },
  );
}
