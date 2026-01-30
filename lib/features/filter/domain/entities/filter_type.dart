enum FilterType { lowestPrice, highestPrice, newest, oldest, discount }

extension FilterTypeExtension on FilterType {
  // القيم اللي هتروح للـ API
  String get queryValue {
    switch (this) {
      case FilterType.lowestPrice:
        return 'price';
      case FilterType.highestPrice:
        return '-price';
      case FilterType.newest:
        return 'new';
      case FilterType.oldest:
        return 'old';
      case FilterType.discount:
        return 'discount';
    }
  }

  String getDisplayName(String languageCode) {
    final isArabic = languageCode == 'ar';
    switch (this) {
      case FilterType.lowestPrice:
        return isArabic ? 'الأقل سعراً' : 'Lowest Price';
      case FilterType.highestPrice:
        return isArabic ? 'الأعلى سعراً' : 'Highest Price';
      case FilterType.newest:
        return isArabic ? 'الأحدث' : 'New';
      case FilterType.oldest:
        return isArabic ? 'الأقدم' : 'Old';
      case FilterType.discount:
        return isArabic ? 'التخفيضات' : 'Discount';
    }
  }
}
