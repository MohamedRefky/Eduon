import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'cubit/video_cubit.dart';
import 'cubit/video_state.dart';
import 'widgets/open_in_youtube_button.dart';
import 'widgets/video_details_section.dart';
import 'widgets/video_time_row.dart';

class VideoScreen extends StatelessWidget {
  final String videoId;
  final String title;
  final String playlistId;
  final String playlistTitle;
  final int totalVideos;
  final String? thumbnailUrl;

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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VideoCubit(
        videoId: videoId,
        playlistId: playlistId,
        playlistTitle: playlistTitle,
        totalVideos: totalVideos,
        thumbnailUrl: thumbnailUrl,
      )..initialize(),
      child: VideoView(
        videoId: videoId,
        title: title,
        playlistTitle: playlistTitle,
      ),
    );
  }
}

class VideoView extends StatefulWidget {
  final String videoId;
  final String title;
  final String playlistTitle;

  const VideoView({
    super.key,
    required this.videoId,
    required this.title,
    required this.playlistTitle,
  });

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> with WidgetsBindingObserver {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
        forceHD: false,
        useHybridComposition: true,
      ),
    )..addListener(_onPlayerUpdate);
  }

  void _onPlayerUpdate() {
    if (!mounted) return;

    final cubit = context.read<VideoCubit>();
    final position = _controller.value.position;
    final duration = _controller.metadata.duration;

    cubit.onPositionChanged(
      currentSeconds: position.inSeconds,
      totalSeconds: duration.inSeconds,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      context.read<VideoCubit>().saveCurrentProgress();
    }
  }

  Future<void> _openInYoutube() async {
    final url = Uri.parse('https://www.youtube.com/watch?v=${widget.videoId}');

    final launched = await launchUrl(url, mode: LaunchMode.externalApplication);

    if (!launched && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open YouTube')));
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, _) => _saveProgress(),
      child: YoutubePlayerBuilder(
        onExitFullScreen: () {},
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
          progressColors: const ProgressBarColors(
            playedColor: Colors.red,
            handleColor: Colors.redAccent,
          ),
          onReady: () => context.read<VideoCubit>().onPlayerReady(),
        ),
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.title.isNotEmpty ? widget.title : 'Video Player',
              ),
            ),
            body: BlocListener<VideoCubit, VideoState>(
              listenWhen: (prev, curr) =>
                  !prev.hasMarkedAsWatched && curr.hasMarkedAsWatched,
              listener: (context, _) => _showCompletionSnackBar(context),
              child: BlocListener<VideoCubit, VideoState>(
                listenWhen: (prev, curr) =>
                    prev.resumeFromSeconds != curr.resumeFromSeconds &&
                    curr.resumeFromSeconds != null,
                listener: (context, state) => _controller.seekTo(
                  Duration(seconds: state.resumeFromSeconds!),
                ),
                child: BlocBuilder<VideoCubit, VideoState>(
                  builder: (context, state) => state.status == VideoStatus.error
                      ? _buildErrorState(context, state)
                      : _buildSuccessState(player),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _saveProgress() {
    context.read<VideoCubit>().saveCurrentProgress();
  }

  void _showCompletionSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: AppSizes.w8),
            Text('Video completed!'),
          ],
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, VideoState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: AppSizes.sp48, color: Colors.red),
          Gap(AppSizes.h16),
          Text(
            state.errorMessage ?? 'Something went wrong',
            textAlign: TextAlign.center,
          ),
          Gap(AppSizes.h16),
          ElevatedButton(
            onPressed: () => context.read<VideoCubit>().initialize(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(Widget player) {
    return ListView(
      padding: EdgeInsets.only(bottom: AppSizes.h24),
      children: [
        player,
        Gap(AppSizes.h16),
        _buildVideoInfo(),
        Gap(AppSizes.h16),
        OpenInYoutubeButton(onPressed: _openInYoutube),
      ],
    );
  }

  Widget _buildVideoInfo() {
    return BlocBuilder<VideoCubit, VideoState>(
      builder: (context, state) => Column(
        children: [
          VideoTimeRow(
            currentTime: state.currentTimeFormatted,
            totalTime: state.totalTimeFormatted,
          ),
          Gap(AppSizes.h16),
          VideoDetailsSection(
            title: widget.title,
            playlistTitle: widget.playlistTitle,
          ),
        ],
      ),
    );
  }
}
