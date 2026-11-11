import 'package:elevate_flower_app/core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneButton extends StatelessWidget {
  const PhoneButton({super.key, required this.phone});
  final String phone;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final Uri launchUri = Uri(scheme: 'tel', path: phone);
        await launchUrl(launchUri);
      },
      child: SvgPicture.asset(AppIcons.iconsPhone, width: 18, height: 18),
    );
  }
}
