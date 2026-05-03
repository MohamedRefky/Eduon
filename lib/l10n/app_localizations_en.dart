// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get signup => 'Sign Up';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forgot_password => 'Forgot Password?';

  @override
  String get dont_have_account => 'Don\'t have an account?';

  @override
  String get already_have_account => 'Already have an account?';

  @override
  String get enter_email => 'Enter your email';

  @override
  String get enter_password => 'Enter your password';

  @override
  String get full_name => 'Full Name';

  @override
  String get google_sign_in => 'Sign in with Google';

  @override
  String get failed_login => 'Login failed. Please try again.';

  @override
  String get failed_google_sign_in =>
      'Failed to sign in with Google. Please try again.';

  @override
  String get invalid_email => 'Please enter a valid email address';

  @override
  String get invalid_password => 'Password must be at least 6 characters long';

  @override
  String get welcome_back => 'Welcome Back';

  @override
  String get login_to_continue => 'Login to continue your learning journey';

  @override
  String get join => 'Join';

  @override
  String get signup_to_start =>
      'Enter your academic details to start your learning journey.';

  @override
  String get email_already_registered =>
      'Email already registered. Please login';

  @override
  String get user_not_found_signup => 'User not found. Please sign up first.';

  @override
  String get password_reset_sent => 'Password reset link sent to your email';

  @override
  String get signin_canceled => 'Sign in canceled';

  @override
  String get enter_email_first => 'Enter your email first';

  @override
  String get check_your_email => 'Check your email';

  @override
  String get password_reset_link_sent_desc =>
      'We sent a password reset link to your email address.';

  @override
  String get ok => 'OK';

  @override
  String get wrong_password => 'Incorrect password.';

  @override
  String get invalid_credential => 'Invalid email or password.';

  @override
  String get too_many_requests => 'Too many attempts. Please try again later.';

  @override
  String get network_error => 'Network error. Please check your internet.';

  @override
  String get auth_failed => 'Authentication failed.';

  @override
  String get registration_failed => 'Registration failed.';

  @override
  String get or_continue_with => 'OR CONTINUE WITH';

  @override
  String get every_day => 'Every day';

  @override
  String get weekends => 'Weekends';

  @override
  String get weekdays => 'Weekdays';

  @override
  String get please_enter_email => 'Please enter your email';

  @override
  String get email_must_contain_at => 'Email must contain @';

  @override
  String get enter_valid_email => 'Enter a valid email (name@email.com)';

  @override
  String get please_enter_password => 'Please enter your password';

  @override
  String get password_no_spaces => 'Password must not contain spaces';

  @override
  String get password_at_least_6 => 'Password must be at least 6 characters';

  @override
  String get weak_password => 'Weak password. Use letters & numbers.';

  @override
  String get please_enter_full_name => 'Please enter your full name';

  @override
  String get name_too_short => 'Name is too short';

  @override
  String get name_letters_only => 'Name must contain letters only';

  @override
  String get enter_first_last_name => 'Please enter first & last name';

  @override
  String get google => 'Google';

  @override
  String get which_year => 'Which year are you in?';

  @override
  String get select_academic_year =>
      'Select your current academic year to personalize your curriculum and study resources.';

  @override
  String get continue_text => 'Continue';

  @override
  String get first_year => 'First Year';

  @override
  String get first_year_desc => 'Freshman - Foundation courses & core basics';

  @override
  String get second_year => 'Second Year';

  @override
  String get second_year_desc =>
      'Sophomore - Intermediate concepts & electives';

  @override
  String get third_year => 'Third Year';

  @override
  String get third_year_desc => 'Junior - Advanced majors & specialization';

  @override
  String get fourth_year => 'Fourth Year';

  @override
  String get fourth_year_desc => 'Senior - Thesis, internship & graduation';

  @override
  String academic_year(String year) {
    String _temp0 = intl.Intl.selectLogic(year, {
      'year1': 'First Year',
      'year2': 'Second Year',
      'year3': 'Third Year',
      'year4': 'Fourth Year',
      'other': 'No year selected',
    });
    return '$_temp0';
  }

  @override
  String get skip => 'Skip';

  @override
  String get get_started => 'Get Started';

  @override
  String get next => 'Next';

  @override
  String get onboarding_title_1 => 'Shape Your Future';

  @override
  String get onboarding_desc_1 =>
      'Your personal guide to university success and self-development. Let\'s start the journey';

  @override
  String get onboarding_title_2 => 'Develop real-world skills';

  @override
  String get onboarding_desc_2 =>
      'Skills that take you further. Simple tips and tools to help you grow beyond your university lectures.';

  @override
  String get onboarding_title_3 =>
      'Explore student activities and campus opportunities';

  @override
  String get onboarding_desc_3 =>
      'Don\'t just study, live the experience. Join student clubs, find campus events, and make the most of your university life.';

  @override
  String get home => 'Home';

  @override
  String get courses => 'Courses';

  @override
  String get ai => 'Ai';

  @override
  String get activities => 'Activities';

  @override
  String get profile => 'Profile';

  @override
  String get hello => 'Hello,';

  @override
  String get user => 'User';

  @override
  String get hi => 'Hi,';

  @override
  String get ready_to_learn => 'Ready to turn \nlearning on?';

  @override
  String get student_guide => 'Student Guide';

  @override
  String get student_guide_desc =>
      'Start your journey and learn what to do in your academic year.';

  @override
  String get view_guide => 'View Guide';

  @override
  String get learning_paths => 'Learning Paths';

  @override
  String courses_count(Object count) {
    return '$count Courses';
  }

  @override
  String get start_now => 'Start Now';

  @override
  String get popular_courses => 'Popular Courses';

  @override
  String get view_all => 'View all';

  @override
  String lessons_count(Object count) {
    return 'Lessons $count';
  }

  @override
  String get my_profile => 'My Profile';

  @override
  String get study_reminders => 'Study Reminders';

  @override
  String get logout => 'Logout';

  @override
  String get active_learning => 'Active Learning';

  @override
  String videos_completed(num watched, num total, num percentage) {
    return 'Completed $watched/$total videos • $percentage%';
  }

  @override
  String get no_year_selected => 'No year selected';

  @override
  String get edit_profile => 'Edit Profile';

  @override
  String get select_year => 'Select Year';

  @override
  String get save_changes => 'Save Changes';

  @override
  String get gallery => 'Gallery';

  @override
  String get camera => 'Camera';

  @override
  String get add_reminder => 'Add Reminder';

  @override
  String get no_reminders_yet => 'No reminders yet';

  @override
  String get tap_to_schedule =>
      'Tap + Add Reminder to schedule your study sessions';

  @override
  String get new_study_reminder => 'New Study Reminder';

  @override
  String get label_optional => 'Label (optional)';

  @override
  String get label_hint => 'e.g. Math revision';

  @override
  String get time => 'Time';

  @override
  String get days => 'Days';

  @override
  String get save_reminder => 'Save Reminder';

  @override
  String get notification_denied => 'Notification permission denied.';

  @override
  String get reminder_saved => 'Reminder saved successfully!';

  @override
  String get mon => 'Monday';

  @override
  String get tue => 'Tuesday';

  @override
  String get wed => 'Wednesday';

  @override
  String get thu => 'Thursday';

  @override
  String get fri => 'Friday';

  @override
  String get sat => 'Saturday';

  @override
  String get sun => 'Sunday';

  @override
  String get ask_ai => 'Ask AI anything...';

  @override
  String get students_activities => 'Students Activities';

  @override
  String get featured_clubs => 'Featured Clubs';

  @override
  String get featured_clubs_desc =>
      'Connect with like-minded students, lead initiatives, and build a vibrant university experience beyond the classroom.';

  @override
  String get all => 'All';

  @override
  String get no_results => 'No results found';

  @override
  String get no_courses => 'No courses found';

  @override
  String get level_up_future => 'LEVEL UP YOUR FUTURE';

  @override
  String get explore_courses => 'Explore\nCourses';

  @override
  String get search_courses => 'Search for courses';

  @override
  String get design => 'Design';

  @override
  String get tech => 'Tech';

  @override
  String get soft_skills => 'Soft Skills';

  @override
  String get video_editing => 'Video Editing';

  @override
  String get business => 'Business';

  @override
  String get no_reminders_message =>
      'Tap + Add Reminder to schedule your study sessions';

  @override
  String get could_not_open_youtube => 'Could not open YouTube';

  @override
  String get video_player => 'Video Player';

  @override
  String get video_completed => 'Video completed!';

  @override
  String get something_went_wrong => 'Something went wrong';

  @override
  String get retry => 'Retry';

  @override
  String get open_in_youtube => 'Open in YouTube';

  @override
  String get course_details => 'Course Details';

  @override
  String get learning_path => 'Learning Path';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete_reminder_title => 'Delete Reminder';

  @override
  String delete_reminder_confirm(Object label) {
    return 'Are you sure you want to delete \"$label\"?';
  }

  @override
  String get edit_reminder => 'Edit Reminder';

  @override
  String get update_reminder => 'Update Reminder';

  @override
  String get reminder_updated => 'Reminder updated successfully!';

  @override
  String get study_session => 'Study Session';

  @override
  String get copy_success => 'Message copied to clipboard';

  @override
  String get freshman_guide => 'Freshman Guide';

  @override
  String get senior_guide => 'Senior Guide';

  @override
  String get beginner => 'Beginner';

  @override
  String get intermediate => 'Intermediate';

  @override
  String get web_dev_title => 'Web Development';

  @override
  String get web_dev_desc => 'HTML, CSS, JavaScript';

  @override
  String get cpp_title => 'C++ Programming';

  @override
  String get cpp_desc => 'Learn C++ and solve programming problems';

  @override
  String get ui_ux_title => 'UI/UX Design';

  @override
  String get ui_ux_desc => 'Learn UI/UX design from scratch';

  @override
  String get business_title => 'Business Skills';

  @override
  String get business_desc => 'Learn business and marketing skills';

  @override
  String get soft_skills_path_title => 'Soft Skills';

  @override
  String get soft_skills_path_desc =>
      'Improve your personal and communication skills';

  @override
  String get loading_course => 'Loading course...';

  @override
  String get no_videos_found => 'No videos found';

  @override
  String get loading => 'Loading...';

  @override
  String get clear_chat => 'Clear Chat';

  @override
  String get ai_is_typing => 'AI is typing';

  @override
  String get error_occurred => 'Error occurred';

  @override
  String get profile_updated => 'Profile updated successfully';

  @override
  String get course_removed => 'Course removed successfully';

  @override
  String get ai_empty_message => 'Please enter a message or select an image';

  @override
  String get ai_image_prompt => 'What is in this image?';

  @override
  String get ai_no_response => 'No response generated';

  @override
  String get year_1_2 => 'Year 1 & 2';

  @override
  String get year_3_4 => 'Year 3 & 4';

  @override
  String get tip_network_title => 'Expand Your Network';

  @override
  String get tip_network_desc =>
      'Connect with students from all majors Your university network is your future\'s greatest asset.';

  @override
  String get tip_time_title => 'Master Your Time';

  @override
  String get tip_time_desc =>
      'Learn to balance study, life, and hobbies. Good habits now prevent burnout later.';

  @override
  String get tip_soft_skills_title => 'Focus on Soft Skills';

  @override
  String get tip_soft_skills_desc =>
      'Work on your communication Sharing your ideas clearly is the key to professional success.';

  @override
  String get tip_explore_title => 'Explore & Discover';

  @override
  String get tip_explore_desc =>
      'Don\'t limit yourself to your major, Join clubs, Events and explore new interests outside your field.';

  @override
  String get tip_professional_title => 'Go Professional';

  @override
  String get tip_professional_desc =>
      'Start your LinkedIn profile. Connect with experts and observe how your industry operates.';

  @override
  String get tip_consistent_title => 'Stay Consistent';

  @override
  String get tip_consistent_desc =>
      'Small daily efforts beat sudden hard work Build a routine that helps you grow every day.';

  @override
  String get tip_experience_title => 'Gain Experience';

  @override
  String get tip_experience_desc =>
      'Seek any internship or volunteer work Learning \"work culture\" is as vital as the job itself.';

  @override
  String get tip_problems_title => 'Solve Problems';

  @override
  String get tip_problems_desc =>
      'Train your mind to find solutions, not just identify issues A proactive attitude wins everywhere.';

  @override
  String get club_fares_toson_name => 'Fares Toson Academy';

  @override
  String get club_fares_toson_desc =>
      'A professional platform for mastering 3D video editing and motion design, helping you turn creative skills into real income.';

  @override
  String get club_fares_toson_tag => '3D Video Editing & Monetization';

  @override
  String get club_ieee_name => 'IEEE Student Branch';

  @override
  String get club_ieee_desc =>
      'Global technical organization for the advancement of technology and innovation.';

  @override
  String get club_ieee_tag => 'Technical workshops & networking';

  @override
  String get club_microsoft_name => 'Microsoft Student Club';

  @override
  String get club_microsoft_desc =>
      'Global student community dedicated to fostering innovation through Microsoft software and tools.';

  @override
  String get club_microsoft_tag => 'Software development';

  @override
  String get club_google_name => 'Google Developer Groups';

  @override
  String get club_google_desc =>
      'Global community for developers to learn, connect, and build using Google technologies.';

  @override
  String get club_google_tag => 'Google technologies & hands-on learning';

  @override
  String get club_oi_hub_name => 'Oi HUB';

  @override
  String get club_oi_hub_desc =>
      'Innovation hub connecting students to entrepreneurship and professional career skills.';

  @override
  String get club_oi_hub_tag => 'Innovation hub & career development';

  @override
  String get club_oi_rov_name => 'Oi ROV';

  @override
  String get club_oi_rov_desc =>
      'Technical team dedicated to the design and development of Remotely Operated Vehicles.';

  @override
  String get club_oi_rov_tag => 'Robotics engineering & practical hardware';

  @override
  String get club_icpc_name => 'ICPC OBOUR';

  @override
  String get club_icpc_desc =>
      'Specialized community focused on algorithmic excellence and competitive programming standards.';

  @override
  String get club_icpc_tag => 'Problem solving & competitive programming';

  @override
  String get club_robotics_name => 'ROBOTICS';

  @override
  String get club_robotics_desc =>
      'Specialized technical community dedicated to the fields of autonomous systems, embedded electronics, and practical robotics design.';

  @override
  String get club_robotics_tag => 'Hands-on engineering & innovation projects';

  @override
  String get error_opening_link => 'Could not open link';
}
