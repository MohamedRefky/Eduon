import 'package:eduon/features/courses/bloc/courses_bloc.dart';
import 'package:eduon/features/courses/bloc/courses_event.dart';
import 'package:eduon/features/activities/activities_screen.dart';
import 'package:eduon/features/courses/courses_screen.dart';
import 'package:eduon/features/eduon_ai/screen/eduon_ai_screen.dart';
import 'package:eduon/features/home/home_screen.dart';
import 'package:eduon/features/profile/profile_screen.dart';
import 'package:eduon/features/courses/data/course_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eduon/l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();

    screens = [
      HomeScreen(),
      CoursesScreen(),
      EduonAiScreen(),
      ActivitiesScreen(),
      ProfileScreen(),
    ];
  }

  void changeTab(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CoursesBloc(repository: CourseRepository())
            ..add(GetAllCategoriesEvent()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        body: IndexedStack(index: _currentIndex, children: screens),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: changeTab,
          selectedFontSize: 12,
          unselectedFontSize: 11,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).cardColor,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svg/Home.svg",
                colorFilter: ColorFilter.mode(
                  _currentIndex == 0 ? Theme.of(context).primaryColor : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: AppLocalizations.of(context)!.home,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svg/courses.svg",
                colorFilter: ColorFilter.mode(
                  _currentIndex == 1 ? Theme.of(context).primaryColor : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: AppLocalizations.of(context)!.courses,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svg/chat boot.svg",
                colorFilter: ColorFilter.mode(
                  _currentIndex == 2 ? Theme.of(context).primaryColor : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: AppLocalizations.of(context)!.ai,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svg/activites.svg",
                colorFilter: ColorFilter.mode(
                  _currentIndex == 3 ? Theme.of(context).primaryColor : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: AppLocalizations.of(context)!.activities,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svg/profile.svg",
                colorFilter: ColorFilter.mode(
                  _currentIndex == 4 ? Theme.of(context).primaryColor : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: AppLocalizations.of(context)!.profile,
            ),
          ],
        ),
      ),
    );
  }
}
