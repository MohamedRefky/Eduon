import 'package:flutter/material.dart';
import 'package:eduon/l10n/app_localizations.dart';

class ActivitiesConstants {
  static List<Map<String, dynamic>> getClubs(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      {
        'name': l10n.club_fares_toson_name,
        'description': l10n.club_fares_toson_desc,
        'tag': l10n.club_fares_toson_tag,
        'image': 'assets/images/Fares_Toson_Academy.jpg',
        'color': const Color(0xFF000000),
        'link': 'https://farestoson.com/',
      },
      {
        'name': l10n.club_ieee_name,
        'description': l10n.club_ieee_desc,
        'tag': l10n.club_ieee_tag,
        'image': 'assets/images/IEEE.png',
        'svg': 'assets/svg/IEEE.svg',
        'color': const Color(0xFF1A237E),
        'link': 'https://www.facebook.com/IEEE.org',
      },
      {
        'name': l10n.club_microsoft_name,
        'description': l10n.club_microsoft_desc,
        'tag': l10n.club_microsoft_tag,
        'image': 'assets/images/Microsoft_student_Club.png',
        'svg': 'assets/svg/Microsoft_student_Club.svg',
        'color': const Color(0xFF0078D4),
        'link': 'https://www.facebook.com/aoumsc',
      },
      {
        'name': l10n.club_google_name,
        'description': l10n.club_google_desc,
        'tag': l10n.club_google_tag,
        'image': 'assets/images/Google_Developer_Groups.png',
        'svg': 'assets/svg/google-developers.svg',
        'color': const Color(0xFF1B5E20),
        'link': 'https://www.facebook.com/GDGCairo',
      },
      {
        'name': l10n.club_oi_hub_name,
        'description': l10n.club_oi_hub_desc,
        'tag': l10n.club_oi_hub_tag,
        'image': 'assets/images/Oi_HUB.png',
        'svg': 'assets/svg/Oi_HUB.svg',
        'color': const Color(0xFF212121),
        'link': 'https://www.facebook.com/OIHUB',
      },
      {
        'name': l10n.club_oi_rov_name,
        'description': l10n.club_oi_rov_desc,
        'tag': l10n.club_oi_rov_tag,
        'image': 'assets/images/Oi_ROV.png',
        'svg': 'assets/svg/Oi_ROV.svg',
        'color': const Color(0xFF263238),
        'link': 'https://www.facebook.com/OIROV',
      },
      {
        'name': l10n.club_icpc_name,
        'description': l10n.club_icpc_desc,
        'tag': l10n.club_icpc_tag,
        'image': 'assets/images/ICPC_OBOUR.png',
        'svg': 'assets/svg/ICPC_OBOUR.svg',
        'color': const Color(0xFF4A148C),
        'link': 'https://www.facebook.com/OI.CPC1',
      },
      {
        'name': l10n.club_robotics_name,
        'description': l10n.club_robotics_desc,
        'tag': l10n.club_robotics_tag,
        'image': 'assets/images/ROBOTICS.png',
        'svg': 'assets/svg/ROBOTICS.svg',
        'color': const Color.fromARGB(255, 132, 128, 128),
        'link': 'https://www.facebook.com/oi.robotics',
      },
    ];
  }
}
