import 'terms_content_model.dart';

class TermsSectionModel {
  final TermsContent termsContent;

  TermsSectionModel({
    required this.termsContent,
  });

  factory TermsSectionModel.fromJson(Map<String, dynamic> json) {
    return TermsSectionModel(
      termsContent: TermsContent.fromJson(json),
    );
  }
}