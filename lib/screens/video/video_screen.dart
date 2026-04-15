import 'package:eduon/core/service/video_progress_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String videoId;
  final String title;
  final String playlistId; // ✅ أضف
  final String playlistTitle; // ✅ أضف
  final int totalVideos; // ✅ أضف
  final String? thumbnailUrl; // ✅ أضف (اختياري)

  const VideoScreen({
    super.key,
    required this.videoId,
    required this.playlistId,
    required this.playlistTitle,
    required this.totalVideos,
    this.title = '',
    this.thumbnailUrl,
  });

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  bool _hasMarkedAsWatched = false;

  final VideoProgressService _progressService = VideoProgressService();

  @override
  void initState() {
    super.initState();
    _initializeVideo();

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
        forceHD: false,
        useHybridComposition: true,
      ),
    )..addListener(_listener);
  }

  // ✅ تهيئة الفيديو
  Future<void> _initializeVideo() async {
    // حفظ معلومات الكورس
    await _progressService.saveCourseInfo(
      widget.playlistId,
      widget.playlistTitle,
      widget.totalVideos,
      widget.thumbnailUrl,
    );

    // إضافة للكورسات النشطة
    await _progressService.addToActiveCourses(widget.playlistId);

    // جلب آخر موضع
    final position = await _progressService.getVideoPosition(widget.videoId);
    if (position != null && position > 5) {
      _controller.seekTo(Duration(seconds: position));
    }
  }

  void _listener() {
    if (_isPlayerReady && mounted) {
      final position = _controller.value.position;
      final duration = _controller.metadata.duration;

      // حفظ التقدم كل 5 ثواني
      if (position.inSeconds % 5 == 0 && position.inSeconds > 0) {
        _progressService.saveVideoPosition(
          widget.videoId,
          position.inSeconds,
          duration.inSeconds,
        );
      }

      // إذا وصل 90%، احفظه كمكتمل
      if (!_hasMarkedAsWatched &&
          duration.inSeconds > 0 &&
          (position.inSeconds / duration.inSeconds) >= 0.9) {
        _markAsWatched();
      }

      setState(() {});
    }
  }

  Future<void> _markAsWatched() async {
    _hasMarkedAsWatched = true;
    await _progressService.markAsWatched(widget.playlistId, widget.videoId);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text('✅ Video completed!'),
            ],
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void deactivate() {
    // حفظ الموضع عند الخروج
    final position = _controller.value.position;
    final duration = _controller.metadata.duration;
    _progressService.saveVideoPosition(
      widget.videoId,
      position.inSeconds,
      duration.inSeconds,
    );

    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openInYoutube() async {
    final url = Uri.parse('https://www.youtube.com/watch?v=${widget.videoId}');
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open YouTube')),
        );
      }
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {},
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: const ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.redAccent,
        ),
        onReady: () {
          _isPlayerReady = true;
        },
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.title.isNotEmpty ? widget.title : 'Video Player',
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              player,
              const SizedBox(height: 16),

              // عرض التقدم
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      _formatDuration(_controller.value.position),
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const Spacer(),
                    Text(
                      _formatDuration(_controller.metadata.duration),
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              if (widget.title.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.playlistTitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton.icon(
                  onPressed: _openInYoutube,
                  icon: const Icon(Icons.play_circle_fill),
                  label: const Text('Open in YouTube'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}