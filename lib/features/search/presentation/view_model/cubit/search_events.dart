sealed class SearchEvents {
  const SearchEvents();

  factory SearchEvents.search({required String keyword, int? limit}) =>
      SearchEvent(keyword: keyword, limit: limit ?? 20);
  factory SearchEvents.loadMore() = LoadMoreEvent;

  void when({
    required Function(String keyword, int limit) search,
    required Function() loadMore,
  }) {
    if (this is SearchEvent) {
      final event = this as SearchEvent;
      search(event.keyword, event.limit);
    } else if (this is LoadMoreEvent) {
      loadMore();
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
