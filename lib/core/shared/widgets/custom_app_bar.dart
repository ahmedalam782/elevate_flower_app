import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_typography.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  // added isCenteredTitle parameter to make title go left if needed
  final bool? isCenteredTitle;
  final EdgeInsetsGeometry? padding;
  final bool automaticallyImplyLeading;
  final Color? textColor;
  final List<Widget>? actions;
  const CustomAppBar({
    super.key,
    required this.title,
    this.isCenteredTitle = false,
    this.padding,
    this.automaticallyImplyLeading = true,
    this.textColor,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final canPop = context.canPop();
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 4),
      child: AppBar(
        leadingWidth: 30,
        titleSpacing: 8,
        // added isCenteredTitle usage make the title go left if needed
        centerTitle: isCenteredTitle ?? true,
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: Text(
          title,
          style: 20.medium.copyWith(color: textColor ?? Colors.black),
        ),
        leading: automaticallyImplyLeading && canPop
            ? InkWell(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                onTap: () {
                  context.pop();
                },
                child: const Icon(Icons.chevron_left, size: 38),
              )
            : null,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
