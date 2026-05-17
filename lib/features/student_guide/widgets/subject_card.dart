import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/localization/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eduon/core/widgets/custom_snack_bar.dart';
import '../data/models/subject_model.dart';
import 'package:eduon/features/courses_details/courses_details_screen.dart';

class SubjectCard extends StatelessWidget {
  final SubjectModel subject;

  const SubjectCard({super.key, required this.subject});

  void _openVideo(BuildContext context) {
    if (subject.videoUrl != null) {
      final url = subject.videoUrl!;
      if (url.contains('playlist?list=')) {
        final listId = Uri.parse(url).queryParameters['list'];
        if (listId != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CourseDetailsScreen(playlistId: listId),
            ),
          );
          return;
        }
      } else {
        String? videoId;
        if (url.contains('youtu.be/')) {
          videoId = url.split('youtu.be/').last.split('?').first;
        } else if (url.contains('watch?v=')) {
          videoId = Uri.parse(url).queryParameters['v'];
        }

        if (videoId != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  CourseDetailsScreen(playlistId: 'subject_$videoId'),
            ),
          );
          return;
        }
      }

      // Fallback if URL parsing fails
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasVideo = subject.videoUrl != null;
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsetsDirectional.only(bottom: AppSizes.h12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppSizes.r12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          onTap: hasVideo ? () => _openVideo(context) : null,
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: AppSizes.w16,
              vertical: AppSizes.h12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    subject.getLocalizedTitle(context),
                    style: textTheme.displayMedium?.copyWith(
                      fontSize: AppSizes.sp15,
                    ),
                  ),
                ),

                if (hasVideo) ...[
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.youtube,
                      color: const Color(0xFFFF0000), // YouTube Red
                      size: AppSizes.sp28,
                    ),
                    onPressed: () async {
                      final url = Uri.parse(subject.videoUrl!);
                      if (!await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      )) {
                        if (context.mounted) {
                          showCustomSnackBar(
                            context,
                            message: l10n.could_not_open_youtube,
                            type: SnackBarType.error,
                          );
                        }
                      }
                    },
                    tooltip: l10n.open_in_youtube_tooltip,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  //Gap(AppSizes.w8),
                ],
                Container(
                  padding: EdgeInsets.all(AppSizes.w10),
                  decoration: BoxDecoration(
                    color: hasVideo
                        ? colorScheme.primary
                        : Colors.grey.shade200,
                    shape: BoxShape.circle,
                    boxShadow: hasVideo
                        ? [
                            BoxShadow(
                              color: colorScheme.primary.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    hasVideo
                        ? Icons.play_arrow_rounded
                        : Icons.menu_book_rounded,
                    color: hasVideo ? Colors.white : Colors.grey.shade500,
                    size: AppSizes.sp20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
