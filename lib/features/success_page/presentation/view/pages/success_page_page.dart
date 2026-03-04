import 'package:elevate_flower_app/features/success_page/presentation/view/widgets/success_page_body.dart';
import 'package:flutter/material.dart';
    
class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SuccessBody(),
    );
  }
}
