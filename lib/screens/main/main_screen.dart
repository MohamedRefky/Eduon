import 'package:eduon/bloc/courses_bloc.dart';
import 'package:eduon/bloc/courses_event.dart';
import 'package:eduon/repository/course_repository.dart';
import 'package:eduon/screens/activities/Activities_screen.dart';
import 'package:eduon/screens/courses/courses_screen.dart';
import 'package:eduon/screens/eduon_aI/edone_ai_screeen.dart';
import 'package:eduon/screens/home/home_screen.dart';
import 'package:eduon/screens/profile/profile_screeen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      EdoneAiScreen(),
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
        backgroundColor: const Color(0xFFF3F4F6),

        body: IndexedStack(index: _currentIndex, children: screens),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
           onTap: changeTab,
         
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/Home.svg"),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/courses.svg"),
              label: "Courses",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/chat boot.svg"),
              label: "Ai",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/activites.svg"),
              label: "Activities",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/profile.svg"),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
