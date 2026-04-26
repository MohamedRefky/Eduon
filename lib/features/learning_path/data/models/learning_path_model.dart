class LearningPathModel {
  final String title;
  final String description;
  final String image;
  final String level;
  final List<String> playlistIds;

  LearningPathModel({
    required this.title,
    required this.description,
    required this.image,
    required this.level,
    required this.playlistIds,
  });

  int get totalCourses => playlistIds.length;
}