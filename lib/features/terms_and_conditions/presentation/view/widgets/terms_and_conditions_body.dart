import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/features/terms_and_conditions/data/models/terms_section_model.dart';
import 'package:flutter/material.dart';

class TermsSectionBody extends StatelessWidget {
  final TermsSectionModel section;
  final String locale;
  final int index;

  const TermsSectionBody({
    super.key,
    required this.section,
    required this.locale,
    required this.index,
  });

  TextAlign get _textAlign => locale == 'ar' ? TextAlign.right : TextAlign.left;

  CrossAxisAlignment get _crossAlign =>
      locale == 'ar' ? CrossAxisAlignment.end : CrossAxisAlignment.start;

  @override
  Widget build(BuildContext context) {
    final sectionType = section.termsContent.section;
    final title = section.termsContent.getTitle(locale);
    final content = section.termsContent.getContent(locale);

    // Skip rendering title and last_updated as they're handled separately
    if (sectionType == 'title' || sectionType == 'last_updated') {
      return const SizedBox.shrink();
    }

    final cardColor = index % 2 == 0
        ? Colors.white
        : AppColors.primerColor.withOpacity(0.02);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: _crossAlign,
        children: [
          // Title Section
          if (title != null) ...[
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.primerColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    textAlign: _textAlign,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primerColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],

          // Content Section
          if (content != null) _buildContent(content),
        ],
      ),
    );
  }

  Widget _buildContent(dynamic content) {
    if (content is String) {
      // Single string content
      return Text(
        content,
        textAlign: _textAlign,
        style: const TextStyle(
          fontSize: 15,
          height: 1.6,
          color: AppColors.black5D,
        ),
      );
    } else if (content is List) {
      // List content - render as bullet points
      return Column(
        crossAxisAlignment: _crossAlign,
        children: content.asMap().entries.map((entry) {
          final itemIndex = entry.key;
          final item = entry.value.toString();
          
          return Padding(
            padding: EdgeInsets.only(
              bottom: itemIndex < content.length - 1 ? 12 : 0,
              right: locale == 'ar' ? 20 : 0,
              left: locale == 'ar' ? 0 : 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: locale == 'ar' ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.primerColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item,
                    textAlign: _textAlign,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: AppColors.black5D,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    }
    
    return const SizedBox.shrink();
  }
}