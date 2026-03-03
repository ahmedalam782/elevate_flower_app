import 'package:elevate_flower_app/core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneButton extends StatelessWidget {
  const PhoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final Uri launchUri = Uri(scheme: 'tel', path: "01207731315");
        await launchUrl(launchUri);
      },
      child: SvgPicture.asset(AppIcons.iconsPhone, width: 18, height: 18),
    );
  }
}