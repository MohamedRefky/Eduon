import 'package:eduon/bloc/courses_bloc.dart';
import 'package:eduon/bloc/courses_event.dart';
import 'package:eduon/bloc/courses_state.dart';
import 'package:eduon/core/models/video_model.dart';
import 'package:eduon/repository/course_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CoursesDetailsScreen extends StatelessWidget {
  final String playlistId;

  const CoursesDetailsScreen({super.key, required this.playlistId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CoursesBloc(repository: CourseRepository())
            ..add(GetPlaylistVideosEvent(playlistId: playlistId)),
      child: const CourseView(),
    );
  }
}

class CourseView extends StatefulWidget {
  const CourseView({super.key});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  YoutubePlayerController? _controller;
  int _currentIndex = 0;
  bool _isPlayerReady = false;
  List<VideoModel> _videos = [];

  void _initPlayer(String videoId) {
    _controller?.dispose();
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        useHybridComposition: true,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted) {
      setState(() {});
    }
  }

  void _playVideo(int index) {
    setState(() {
      _currentIndex = index;
    });
    _controller?.load(_videos[index].videoId);
  }

  void _playNext() {
    if (_currentIndex < _videos.length - 1) {
      _playVideo(_currentIndex + 1);
    }
  }

  void _playPrevious() {
    if (_currentIndex > 0) {
      _playVideo(_currentIndex - 1);
    }
  }

  @override
  void deactivate() {
    _controller?.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        // لو الـ Videos اتحملت للأول مرة
        if (state.selectedPlaylist != null &&
            state.selectedPlaylist!.videos.isNotEmpty &&
            _videos.isEmpty) {
          _videos = state.selectedPlaylist!.videos;
          _initPlayer(_videos[0].videoId);
        }

        return YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller:
                _controller ?? YoutubePlayerController(initialVideoId: ''),
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
            progressColors: const ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.redAccent,
            ),
            onReady: () {
              _isPlayerReady = true;
            },
            onEnded: (data) {
              _playNext();
            },
          ),
          builder: (context, player) {
            return Scaffold(
              appBar: AppBar(title: const Text('Course Details')),
              body: Column(
                children: [
                  // Loading
                  if (state.isPlaylistLoading)
                    const SizedBox(
                      height: 220,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (_videos.isNotEmpty)
                    // Video Player مع الـ Overlay Buttons
                    Stack(
                      children: [
                        // Player
                        player,

                        // Previous Button على الشمال
                        Positioned(
                          left: 8,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: GestureDetector(
                              onTap: _currentIndex > 0 ? _playPrevious : null,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.skip_previous,
                                  color: _currentIndex > 0
                                      ? Colors.white
                                      : Colors.white38,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Next Button على اليمين
                        Positioned(
                          right: 8,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: GestureDetector(
                              onTap: _currentIndex < _videos.length - 1
                                  ? _playNext
                                  : null,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.skip_next,
                                  color: _currentIndex < _videos.length - 1
                                      ? Colors.white
                                      : Colors.white38,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Video Title فوق
                        Positioned(
                          top: 8,
                          left: 50,
                          right: 50,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _videos[_currentIndex].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  const Divider(),

                  // Videos List
                  Expanded(
                    child: _videos.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: _videos.length,
                            itemBuilder: (context, index) {
                              final video = _videos[index];
                              final isPlaying = index == _currentIndex;

                              return ListTile(
                                onTap: () => _playVideo(index),
                                tileColor: isPlaying
                                    ? Colors.deepPurple.withOpacity(0.1)
                                    : null,
                                leading: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        video.thumbnailUrl,
                                        width: 80,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    if (isPlaying)
                                      Container(
                                        width: 80,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                  ],
                                ),
                                title: Text(
                                  video.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: isPlaying
                                        ? Colors.deepPurple
                                        : Colors.black,
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      '#${index + 1}',
                                      style: TextStyle(
                                        color: isPlaying
                                            ? Colors.deepPurple
                                            : Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.remove_red_eye,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _formatViewCount(video.viewCount),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.access_time,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _formatDuration(video.duration),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String _formatViewCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  String _formatDuration(String duration) {
    if (duration.isEmpty) return '';
    final regex = RegExp(r'PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?');
    final match = regex.firstMatch(duration);
    if (match == null) return '';
    final hours = int.tryParse(match.group(1) ?? '0') ?? 0;
    final minutes = int.tryParse(match.group(2) ?? '0') ?? 0;
    final seconds = int.tryParse(match.group(3) ?? '0') ?? 0;
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
