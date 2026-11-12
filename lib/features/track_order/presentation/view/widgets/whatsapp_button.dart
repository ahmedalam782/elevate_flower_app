import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/theme/app_images.dart';

class WhatsappButton extends StatelessWidget {
  const WhatsappButton({super.key, required this.phone});
  final String phone;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await whatsapp(contact: phone);
      },
      child: Image.asset(AppImages.whatsapp, width: 24, height: 24),
    );
  }
}

Future<void> whatsapp({required String contact}) async {
  var Url = "https://wa.me/+20$contact";

  if (Platform.isIOS) {
    await launchUrl(Uri.parse(Url));
  } else {
    await launchUrl(Uri.parse(Url));
  }
}
