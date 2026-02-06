import 'dart:ui';

class SectionStyle {
  final double? fontSize;
  final String? fontWeight;
  final String? color;
  final Map<String, String>? textAlign;
  final String? backgroundColor;

  SectionStyle({
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.backgroundColor,
  });

  factory SectionStyle.fromJson(Map<String, dynamic> json) {
    return SectionStyle(
      fontSize: json['fontSize']?.toDouble(),
      fontWeight: json['fontWeight'],
      color: json['color'],
      textAlign: json['textAlign'] != null
          ? Map<String, String>.from(json['textAlign'])
          : null,
      backgroundColor: json['backgroundColor'],
    );
  }

  FontWeight get fontWeightValue {
    if (fontWeight == 'bold') return FontWeight.bold;
    return FontWeight.normal;
  }

  Color get colorValue {
    return Color(int.parse(color!.replaceFirst('#', '0xFF')));
  }

  Color? get backgroundColorValue {
    if (backgroundColor == null) return null;
    return Color(int.parse(backgroundColor!.replaceFirst('#', '0xFF')));
  }

  TextAlign getTextAlign(String locale) {
    if (textAlign == null) return TextAlign.left;
    final align = textAlign![locale] ?? 'left';
    return align == 'center'
        ? TextAlign.center
        : align == 'right'
            ? TextAlign.right
            : TextAlign.left;
  }
}