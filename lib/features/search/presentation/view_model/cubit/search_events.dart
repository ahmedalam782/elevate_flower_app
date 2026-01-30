sealed class SearchEvents {
  const SearchEvents();

  factory SearchEvents.search({required String keyword, int? limit}) =>
      SearchEvent(keyword: keyword, limit: limit ?? 20);
  factory SearchEvents.loadMore() = LoadMoreEvent;

  Future<void> when({
    required Future<void> Function(String keyword, int limit) search,
    required Future<void> Function() loadMore,
  }) async {
    if (this is SearchEvent) {
      final event = this as SearchEvent;
      await search(event.keyword, event.limit);
    } else if (this is LoadMoreEvent) {
      await loadMore();
    }
  }
}

class SearchEvent extends SearchEvents {
  final String keyword;
  final int limit;

  const SearchEvent({required this.keyword, this.limit = 20});
}

class LoadMoreEvent extends SearchEvents {
  const LoadMoreEvent();
}
