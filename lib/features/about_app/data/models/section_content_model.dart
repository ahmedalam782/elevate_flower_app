class SectionContent {
  final Map<String, dynamic>? content;
  final Map<String, dynamic>? title;

  SectionContent({
    this.content,
    this.title,
  });

  factory SectionContent.fromJson(Map<String, dynamic> json) {
    return SectionContent(
      content: json['content'],
      title: json['title'],
    );
  }

  String? getTitle(String locale) {
    if (title == null) return null;
    return title![locale];
  }

  dynamic getContent(String locale) {
    if (content == null) return null;
    return content![locale];
  }
}