class TermsContent {
  final String section;
  final Map<String, dynamic>? title;
  final Map<String, dynamic> content;
  final Map<String, dynamic>? style;

  TermsContent({
    required this.section,
    this.title,
    required this.content,
    this.style,
  });

  factory TermsContent.fromJson(Map<String, dynamic> json) {
    return TermsContent(
      section: json['section'] ?? '',
      title: json['title'] as Map<String, dynamic>?,
      content: json['content'] as Map<String, dynamic>,
      style: json['style'] as Map<String, dynamic>?,
    );
  }

  String? getTitle(String locale) {
    if (title == null) return null;
    return title![locale];
  }

  dynamic getContent(String locale) {
    return content[locale];
  }

  // Helper to check if content is a list
  bool isContentList(String locale) {
    final contentData = getContent(locale);
    return contentData is List;
  }

  // Helper to get content as string
  String? getContentAsString(String locale) {
    final contentData = getContent(locale);
    if (contentData is String) return contentData;
    return null;
  }

  // Helper to get content as list
  List<String>? getContentAsList(String locale) {
    final contentData = getContent(locale);
    if (contentData is List) {
      return contentData.map((e) => e.toString()).toList();
    }
    return null;
  }
}