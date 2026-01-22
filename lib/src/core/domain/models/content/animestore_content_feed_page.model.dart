abstract class AnimestoreContentFeedPage<T> {
  final T content;
  final int currentPage;
  final int maxPage;

  const AnimestoreContentFeedPage(
      {required this.content,
      required this.currentPage,
      required this.maxPage});
}
