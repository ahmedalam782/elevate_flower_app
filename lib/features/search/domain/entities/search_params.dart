class SearchParams {
  final String keyword;
  final int page;
  final int limit;

  const SearchParams({required this.keyword, this.page = 1, this.limit = 20});

  SearchParams copyWith({String? keyword, int? page, int? limit}) {
    return SearchParams(
      keyword: keyword ?? this.keyword,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }
}
