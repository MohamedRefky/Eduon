import 'playlist_model.dart';

class CategoryModel {
  final String name;
  final List<PlaylistModel> playlists;

  CategoryModel({
    required this.name,
    required this.playlists,
  });

  CategoryModel copyWith({List<PlaylistModel>? playlists}) {
    return CategoryModel(
      name: name,
      playlists: playlists ?? this.playlists,
    );
  }
}