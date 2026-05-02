import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:eduon/l10n/app_localizations.dart';

import 'cubit/course_details_cubit.dart';
import 'cubit/course_details_state.dart';
import 'widgets/course_details_loading.dart';
import 'widgets/video_list_section.dart';
import 'widgets/video_player_section.dart';
import 'package:eduon/core/widgets/custom_snack_bar.dart';

class CourseDetailsScreen extends StatelessWidget {
  final String playlistId;

  const CourseDetailsScreen({super.key, required this.playlistId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CourseDetailsCubit(playlistId: playlistId)..loadPlaylistVideos(),
      child: const _CourseDetailsView(),
    );
  }
}

class _CourseDetailsView extends StatefulWidget {
  const _CourseDetailsView();

  @override
  State<_CourseDetailsView> createState() => _CourseDetailsViewState();
}

class _CourseDetailsViewState extends State<_CourseDetailsView>
    with WidgetsBindingObserver {
  YoutubePlayerController? _controller;
  bool _isPlayerReady = false;

  late final CourseDetailsCubit _cubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _cubit = context.read<CourseDetailsCubit>();
  }

  void _initPlayer(String videoId) {
    _controller?.dispose();
    _isPlayerReady = false;

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        useHybridComposition: true,
      ),
    )..addListener(_onPlayerUpdate);

    setState(() {});
  }

  void _onPlayerUpdate() {
    if (!_isPlayerReady || !mounted || _controller == null) return;

    final position = _controller!.value.position;
    final duration = _controller!.metadata.duration;

    _cubit.onPositionChanged(
      currentSeconds: position.inSeconds,
      totalSeconds: duration.inSeconds,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      _saveProgress();
    }
  }

  void _saveProgress() {
    if (_controller == null) return;

    _cubit.saveCurrentProgress(
      positionSeconds: _controller!.value.position.inSeconds,
      durationSeconds: _controller!.metadata.duration.inSeconds,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _saveProgress();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocListener<CourseDetailsCubit, CourseDetailsState>(
      listenWhen: (previous, current) =>
          !previous.hasMarkedAsWatched && current.hasMarkedAsWatched,
      listener: (context, state) {
        showCustomSnackBar(
          context,
          message: l10n.video_completed,
          type: SnackBarType.success,
        );
      },
      child: BlocConsumer<CourseDetailsCubit, CourseDetailsState>(
        listenWhen: (previous, current) =>
            previous.currentIndex != current.currentIndex ||
            (previous.status != CourseDetailsStatus.loaded &&
                current.status == CourseDetailsStatus.loaded),
        listener: (context, state) {
          if (state.currentVideo != null) {
            if (_controller == null) {
              _initPlayer(state.currentVideo!.videoId);
            } else {
              _controller!.load(state.currentVideo!.videoId);
              _isPlayerReady = false;
            }
          }
        },
        builder: (context, state) {
          return PopScope(
            onPopInvokedWithResult: (_, _) => _saveProgress(),
            child: YoutubePlayerBuilder(
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
                onEnded: (_) => _cubit.playNext(),
              ),
              builder: (context, player) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      state.playlistTitle.isNotEmpty
                          ? state.playlistTitle
                          : l10n.course_details,
                    ),
                  ),
                  body: _buildBody(state, player),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(CourseDetailsState state, Widget player) {
    switch (state.status) {
      case CourseDetailsStatus.initial:
      case CourseDetailsStatus.loading:
        return const CourseDetailsLoading();
      case CourseDetailsStatus.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Lottie.asset('assets/gif/error404.json')],
          ),
        );

      case CourseDetailsStatus.loaded:
        return Column(
          children: [
            VideoPlayerSection(
              player: player,
              state: state,
              onNext: _cubit.playNext,
              onPrevious: _cubit.playPrevious,
            ),
            const Divider(),
            VideoListSection(
              videos: state.videos,
              currentIndex: state.currentIndex,
              onVideoSelected: (index) => _cubit.playVideo(index),
            ),
          ],
        );
    }
  }
}
