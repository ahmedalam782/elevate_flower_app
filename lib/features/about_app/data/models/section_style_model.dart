import 'package:elevate_flower_app/features/about_app/data/models/about_section_model.dart';

import 'section_content_model.dart';

class AboutSectionModel {
  final String section;
  final SectionContent sectionContent;
  final Map<String, SectionStyle>? style;

  AboutSectionModel({
    required this.section,
    required this.sectionContent,
    this.style,
  });

  factory AboutSectionModel.fromJson(Map<String, dynamic> json) {
    Map<String, SectionStyle>? parsedStyles;

    if (json['style'] != null) {
      final styleJson = json['style'] as Map<String, dynamic>;
      parsedStyles = {};

      styleJson.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          parsedStyles![key] = SectionStyle.fromJson(value);
        }
      });

      // Handle flat style (not nested)
      if (parsedStyles.isEmpty && styleJson.containsKey('fontSize')) {
        parsedStyles['content'] = SectionStyle.fromJson(styleJson);
      }
    }

    return AboutSectionModel(
      section: json['section'] ?? '',
      sectionContent: SectionContent.fromJson(json),
      style: parsedStyles,
    );
  }

  SectionStyle? getStyle(String type) {
    return style?[type];
  }
}