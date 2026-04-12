import 'package:eduon/core/models/learning_path_model.dart';

class LearningPathsConstants {
  static final List<LearningPathModel> learningPaths = [
    LearningPathModel(
      title: 'Web Development',
      description: 'HTML, CSS, JavaScript',
      image: 'assets/images/web_course.png',
      level: 'Beginner',
      playlistIds: [
        'PLDoPjvoNmBAw_t_XWUFbBX-c9MafPk9ji', // HTML
        'PLDoPjvoNmBAzjsz06gkzlSrlev53MGIKe', // CSS
        'PLDoPjvoNmBAzLyvrWPwMw6bbBlTwPxgLF', // JS OOP
      ],
    ),
    LearningPathModel(
      title: 'C++ Programming',
      description: 'Learn C++ and solve programming problems',
      image: 'assets/images/c++_course.jpg',
      level: 'Intermediate',
      playlistIds: [
        'PLDoPjvoNmBAz7wegzgoJvVJdr-WwE5Pwt', // C++ Functions
        'PLDoPjvoNmBAyX4CCOP--TR36SfD5g7gru', // C++ Problem Solving
      ],
    ),
    LearningPathModel(
      title: 'UI/UX Design',
      description: 'Learn UI/UX design from scratch',
      image: 'assets/images/ui_ux_course.jpg',
      level: 'Beginner',
      playlistIds: [
        'PLjzhiGLyugKwnM6uN4NXhfpU8L7XvtDEv', // UI/UX
      ],
    ),
    LearningPathModel(
      title: 'Business Skills',
      description: 'Learn business and marketing skills',
      image: 'assets/images/Business_course.jpg',
      level: 'Beginner',
      playlistIds: [
        'PL1O57nCUQ-e-OVRFdIB-Gu1U91yH7egmm', // Business
      ],
    ),
    LearningPathModel(
      title: 'Soft Skills',
      description: 'Improve your personal and communication skills',
      image: 'assets/images/soft_skill_course.jpg',
      level: 'Beginner',
      playlistIds: [
        'PLiY-jf8J2Mplc6151KJnXdzFYT9LO5Drs', // Soft Skills
      ],
    ),
  ];
}
