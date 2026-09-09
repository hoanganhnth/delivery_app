import 'package:flutter/material.dart';

import '../pages/profile_personal_information_page.dart';

class ProfilePersonalInformationScreen extends StatelessWidget {
  const ProfilePersonalInformationScreen({super.key, this.previewMode = false});

  final bool previewMode;

  @override
  Widget build(BuildContext context) =>
      ProfilePersonalInformationPage(previewMode: previewMode);
}
