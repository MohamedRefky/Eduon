import 'package:eduon/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eduon/l10n/app_localizations.dart';

class ClubCardWidget extends StatelessWidget {
  const ClubCardWidget({super.key, required this.club});
  final Map<String, dynamic> club;

  Future<void> _openLink(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $link');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final String link = club['link'] as String? ?? '';
    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.h16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppSizes.r15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.r15),
              topRight: Radius.circular(AppSizes.r15),
            ),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                club['image'] as String? ?? '',
                height: AppSizes.h160,
                width: double.infinity,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: AppSizes.h160,
                    width: double.infinity,
                    color: club['color'] as Color? ?? Colors.grey,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppSizes.h12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (club['svg'] != null) ...[
                      SvgPicture.asset(
                        club['svg'] as String,
                        width: AppSizes.sp16,
                        height: AppSizes.sp16,
                        fit: BoxFit.contain,
                      ),
                      Gap(AppSizes.w8),
                    ],
                    Expanded(
                      child: Text(
                        club['name'] as String,
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: AppSizes.sp15),
                      ),
                    ),
                  ],
                ),
                Gap(AppSizes.h8),
                Text(
                  club['description'] as String,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: AppSizes.sp12,
                    height: 1.5,
                  ),
                ),
                Gap(AppSizes.h4),
                Text(
                  club['tag'] as String,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: AppSizes.sp12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Gap(AppSizes.h12),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: AppSizes.h35,
                    child: ElevatedButton(
                      onPressed: link.isNotEmpty ? () => _openLink(link) : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.r8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: AppSizes.w24),
                      ),
                      child: Text(
                        l10n.join,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Colors.white,
                          fontSize: AppSizes.sp14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
