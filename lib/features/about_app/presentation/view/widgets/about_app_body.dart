import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/features/about_app/data/models/section_style_model.dart';
import 'package:flutter/material.dart';

class AboutAppBody extends StatelessWidget {
  final AboutSectionModel section;
  final String locale;
  final int index;

  const AboutAppBody({
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
    if (section.section == 'title') {
      return _buildTitleSection();
    } else if (section.section == 'introduction') {
      return _buildIntroSection();
    } else if (section.section == 'contact_us') {
      return _buildContactSection();
    } else if (section.section == 'closing') {
      return _buildClosingSection();
    } else {
      return _buildFeatureCard();
    }
  }

  Widget _buildTitleSection() {
    final content = section.sectionContent.getContent(locale);
    return Container(
      margin: const EdgeInsets.all(20),
      child: Text(
        content.toString(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.primerColor,
        ),
      ),
    );
  }

  Widget _buildIntroSection() {
    final content = section.sectionContent.getContent(locale);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primerColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primerColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Text(
        content.toString(),
        textAlign: _textAlign,
        style: const TextStyle(
          fontSize: 16,
          height: 1.6,
          color: AppColors.black35,
        ),
      ),
    );
  }

  Widget _buildFeatureCard() {
    final title = section.sectionContent.getTitle(locale);
    final content = section.sectionContent.getContent(locale);

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
          _buildContentText(content),
        ],
      ),
    );
  }

  Widget _buildContentText(dynamic content) {
    if (content is String) {
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
      return Column(
        crossAxisAlignment: _crossAlign,
        children: content.asMap().entries.map((entry) {
          final item = entry.value.toString();
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
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

  Widget _buildContactSection() {
    final title = section.sectionContent.getTitle(locale);
    final content = section.sectionContent.getContent(locale);

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primerColor.withOpacity(0.1),
            AppColors.primerColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primerColor.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primerColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.contact_support_rounded,
              size: 32,
              color: AppColors.primerColor,
            ),
          ),
          const SizedBox(height: 16),
          if (title != null) ...[
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primerColor,
              ),
            ),
            const SizedBox(height: 16),
          ],
          _buildContentText(content),
        ],
      ),
    );
  }

  Widget _buildClosingSection() {
    final content = section.sectionContent.getContent(locale);
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primerColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primerColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite_rounded,
              size: 32,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            content.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
