import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_password;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_account;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_account;

  /// No description provided for @enter_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enter_email;

  /// No description provided for @enter_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enter_password;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// No description provided for @google_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get google_sign_in;

  /// No description provided for @failed_login.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please try again.'**
  String get failed_login;

  /// No description provided for @failed_google_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Failed to sign in with Google. Please try again.'**
  String get failed_google_sign_in;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalid_email;

  /// No description provided for @invalid_password.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long'**
  String get invalid_password;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcome_back;

  /// No description provided for @login_to_continue.
  ///
  /// In en, this message translates to:
  /// **'Login to continue your learning journey'**
  String get login_to_continue;

  /// No description provided for @join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get join;

  /// No description provided for @signup_to_start.
  ///
  /// In en, this message translates to:
  /// **'Enter your academic details to start your learning journey.'**
  String get signup_to_start;

  /// No description provided for @or_continue_with.
  ///
  /// In en, this message translates to:
  /// **'OR CONTINUE WITH'**
  String get or_continue_with;

  /// No description provided for @google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @which_year.
  ///
  /// In en, this message translates to:
  /// **'Which year are you in?'**
  String get which_year;

  /// No description provided for @select_academic_year.
  ///
  /// In en, this message translates to:
  /// **'Select your current academic year to personalize your curriculum and study resources.'**
  String get select_academic_year;

  /// No description provided for @continue_text.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_text;

  /// No description provided for @first_year.
  ///
  /// In en, this message translates to:
  /// **'First Year'**
  String get first_year;

  /// No description provided for @first_year_desc.
  ///
  /// In en, this message translates to:
  /// **'Freshman - Foundation courses & core basics'**
  String get first_year_desc;

  /// No description provided for @second_year.
  ///
  /// In en, this message translates to:
  /// **'Second Year'**
  String get second_year;

  /// No description provided for @second_year_desc.
  ///
  /// In en, this message translates to:
  /// **'Sophomore - Intermediate concepts & electives'**
  String get second_year_desc;

  /// No description provided for @third_year.
  ///
  /// In en, this message translates to:
  /// **'Third Year'**
  String get third_year;

  /// No description provided for @third_year_desc.
  ///
  /// In en, this message translates to:
  /// **'Junior - Advanced majors & specialization'**
  String get third_year_desc;

  /// No description provided for @fourth_year.
  ///
  /// In en, this message translates to:
  /// **'Fourth Year'**
  String get fourth_year;

  /// No description provided for @fourth_year_desc.
  ///
  /// In en, this message translates to:
  /// **'Senior - Thesis, internship & graduation'**
  String get fourth_year_desc;

  /// No description provided for @academic_year.
  ///
  /// In en, this message translates to:
  /// **'{year, select, year1{First Year} year2{Second Year} year3{Third Year} year4{Fourth Year} other{No year selected}}'**
  String academic_year(String year);

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_started;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @onboarding_title_1.
  ///
  /// In en, this message translates to:
  /// **'Shape Your Future'**
  String get onboarding_title_1;

  /// No description provided for @onboarding_desc_1.
  ///
  /// In en, this message translates to:
  /// **'Your personal guide to university success and self-development. Let\'s start the journey'**
  String get onboarding_desc_1;

  /// No description provided for @onboarding_title_2.
  ///
  /// In en, this message translates to:
  /// **'Develop real-world skills'**
  String get onboarding_title_2;

  /// No description provided for @onboarding_desc_2.
  ///
  /// In en, this message translates to:
  /// **'Skills that take you further. Simple tips and tools to help you grow beyond your university lectures.'**
  String get onboarding_desc_2;

  /// No description provided for @onboarding_title_3.
  ///
  /// In en, this message translates to:
  /// **'Explore student activities and campus opportunities'**
  String get onboarding_title_3;

  /// No description provided for @onboarding_desc_3.
  ///
  /// In en, this message translates to:
  /// **'Don\'t just study, live the experience. Join student clubs, find campus events, and make the most of your university life.'**
  String get onboarding_desc_3;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @courses.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get courses;

  /// No description provided for @ai.
  ///
  /// In en, this message translates to:
  /// **'Ai'**
  String get ai;

  /// No description provided for @activities.
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get activities;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello,'**
  String get hello;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @hi.
  ///
  /// In en, this message translates to:
  /// **'Hi,'**
  String get hi;

  /// No description provided for @ready_to_learn.
  ///
  /// In en, this message translates to:
  /// **'Ready to turn \nlearning on?'**
  String get ready_to_learn;

  /// No description provided for @student_guide.
  ///
  /// In en, this message translates to:
  /// **'Student Guide'**
  String get student_guide;

  /// No description provided for @student_guide_desc.
  ///
  /// In en, this message translates to:
  /// **'Start your journey and learn what to do in your academic year.'**
  String get student_guide_desc;

  /// No description provided for @view_guide.
  ///
  /// In en, this message translates to:
  /// **'View Guide'**
  String get view_guide;

  /// No description provided for @learning_paths.
  ///
  /// In en, this message translates to:
  /// **'Learning Paths'**
  String get learning_paths;

  /// No description provided for @courses_count.
  ///
  /// In en, this message translates to:
  /// **'{count} Courses'**
  String courses_count(Object count);

  /// No description provided for @start_now.
  ///
  /// In en, this message translates to:
  /// **'Start Now'**
  String get start_now;

  /// No description provided for @popular_courses.
  ///
  /// In en, this message translates to:
  /// **'Popular Courses'**
  String get popular_courses;

  /// No description provided for @view_all.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get view_all;

  /// No description provided for @lessons_count.
  ///
  /// In en, this message translates to:
  /// **'Lessons {count}'**
  String lessons_count(Object count);

  /// No description provided for @my_profile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get my_profile;

  /// No description provided for @study_reminders.
  ///
  /// In en, this message translates to:
  /// **'Study Reminders'**
  String get study_reminders;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @active_learning.
  ///
  /// In en, this message translates to:
  /// **'Active Learning'**
  String get active_learning;

  /// No description provided for @videos_completed.
  ///
  /// In en, this message translates to:
  /// **'Completed {watched}/{total} videos • {percentage}%'**
  String videos_completed(num watched, num total, num percentage);

  /// No description provided for @no_year_selected.
  ///
  /// In en, this message translates to:
  /// **'No year selected'**
  String get no_year_selected;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// No description provided for @select_year.
  ///
  /// In en, this message translates to:
  /// **'Select Year'**
  String get select_year;

  /// No description provided for @save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get save_changes;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @add_reminder.
  ///
  /// In en, this message translates to:
  /// **'Add Reminder'**
  String get add_reminder;

  /// No description provided for @no_reminders_yet.
  ///
  /// In en, this message translates to:
  /// **'No reminders yet'**
  String get no_reminders_yet;

  /// No description provided for @tap_to_schedule.
  ///
  /// In en, this message translates to:
  /// **'Tap + Add Reminder to schedule your study sessions'**
  String get tap_to_schedule;

  /// No description provided for @new_study_reminder.
  ///
  /// In en, this message translates to:
  /// **'New Study Reminder'**
  String get new_study_reminder;

  /// No description provided for @label_optional.
  ///
  /// In en, this message translates to:
  /// **'Label (optional)'**
  String get label_optional;

  /// No description provided for @label_hint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Math revision'**
  String get label_hint;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @save_reminder.
  ///
  /// In en, this message translates to:
  /// **'Save Reminder'**
  String get save_reminder;

  /// No description provided for @notification_denied.
  ///
  /// In en, this message translates to:
  /// **'Notification permission denied.'**
  String get notification_denied;

  /// No description provided for @reminder_saved.
  ///
  /// In en, this message translates to:
  /// **'Reminder saved successfully!'**
  String get reminder_saved;

  /// No description provided for @mon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get mon;

  /// No description provided for @tue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tue;

  /// No description provided for @wed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wed;

  /// No description provided for @thu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thu;

  /// No description provided for @fri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get fri;

  /// No description provided for @sat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get sat;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sun;

  /// No description provided for @ask_ai.
  ///
  /// In en, this message translates to:
  /// **'Ask AI anything...'**
  String get ask_ai;

  /// No description provided for @students_activities.
  ///
  /// In en, this message translates to:
  /// **'Students Activities'**
  String get students_activities;

  /// No description provided for @featured_clubs.
  ///
  /// In en, this message translates to:
  /// **'Featured Clubs'**
  String get featured_clubs;

  /// No description provided for @featured_clubs_desc.
  ///
  /// In en, this message translates to:
  /// **'Connect with like-minded students, lead initiatives, and build a vibrant university experience beyond the classroom.'**
  String get featured_clubs_desc;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @no_results.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get no_results;

  /// No description provided for @no_courses.
  ///
  /// In en, this message translates to:
  /// **'No courses found'**
  String get no_courses;

  /// No description provided for @level_up_future.
  ///
  /// In en, this message translates to:
  /// **'LEVEL UP YOUR FUTURE'**
  String get level_up_future;

  /// No description provided for @explore_courses.
  ///
  /// In en, this message translates to:
  /// **'Explore\nCourses'**
  String get explore_courses;

  /// No description provided for @search_courses.
  ///
  /// In en, this message translates to:
  /// **'Search for courses'**
  String get search_courses;

  /// No description provided for @design.
  ///
  /// In en, this message translates to:
  /// **'Design'**
  String get design;

  /// No description provided for @tech.
  ///
  /// In en, this message translates to:
  /// **'Tech'**
  String get tech;

  /// No description provided for @soft_skills.
  ///
  /// In en, this message translates to:
  /// **'Soft Skills'**
  String get soft_skills;

  /// No description provided for @video_editing.
  ///
  /// In en, this message translates to:
  /// **'Video Editing'**
  String get video_editing;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @no_reminders_message.
  ///
  /// In en, this message translates to:
  /// **'Tap + Add Reminder to schedule your study sessions'**
  String get no_reminders_message;

  /// No description provided for @could_not_open_youtube.
  ///
  /// In en, this message translates to:
  /// **'Could not open YouTube'**
  String get could_not_open_youtube;

  /// No description provided for @video_player.
  ///
  /// In en, this message translates to:
  /// **'Video Player'**
  String get video_player;

  /// No description provided for @video_completed.
  ///
  /// In en, this message translates to:
  /// **'Video completed!'**
  String get video_completed;

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get something_went_wrong;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @open_in_youtube.
  ///
  /// In en, this message translates to:
  /// **'Open in YouTube'**
  String get open_in_youtube;

  /// No description provided for @course_details.
  ///
  /// In en, this message translates to:
  /// **'Course Details'**
  String get course_details;

  /// No description provided for @learning_path.
  ///
  /// In en, this message translates to:
  /// **'Learning Path'**
  String get learning_path;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete_reminder_title.
  ///
  /// In en, this message translates to:
  /// **'Delete Reminder'**
  String get delete_reminder_title;

  /// No description provided for @delete_reminder_confirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{label}\"?'**
  String delete_reminder_confirm(Object label);

  /// No description provided for @edit_reminder.
  ///
  /// In en, this message translates to:
  /// **'Edit Reminder'**
  String get edit_reminder;

  /// No description provided for @update_reminder.
  ///
  /// In en, this message translates to:
  /// **'Update Reminder'**
  String get update_reminder;

  /// No description provided for @reminder_updated.
  ///
  /// In en, this message translates to:
  /// **'Reminder updated successfully!'**
  String get reminder_updated;

  /// No description provided for @study_session.
  ///
  /// In en, this message translates to:
  /// **'Study Session'**
  String get study_session;

  /// No description provided for @copy_success.
  ///
  /// In en, this message translates to:
  /// **'Message copied to clipboard'**
  String get copy_success;

  /// No description provided for @freshman_guide.
  ///
  /// In en, this message translates to:
  /// **'Freshman Guide'**
  String get freshman_guide;

  /// No description provided for @senior_guide.
  ///
  /// In en, this message translates to:
  /// **'Senior Guide'**
  String get senior_guide;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @clear_chat.
  ///
  /// In en, this message translates to:
  /// **'Clear Chat'**
  String get clear_chat;

  /// No description provided for @ai_is_typing.
  ///
  /// In en, this message translates to:
  /// **'AI is typing'**
  String get ai_is_typing;

  /// No description provided for @error_occurred.
  ///
  /// In en, this message translates to:
  /// **'Error occurred'**
  String get error_occurred;

  /// No description provided for @profile_updated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profile_updated;

  /// No description provided for @course_removed.
  ///
  /// In en, this message translates to:
  /// **'Course removed successfully'**
  String get course_removed;

  /// No description provided for @ai_empty_message.
  ///
  /// In en, this message translates to:
  /// **'Please enter a message or select an image'**
  String get ai_empty_message;

  /// No description provided for @ai_image_prompt.
  ///
  /// In en, this message translates to:
  /// **'What is in this image?'**
  String get ai_image_prompt;

  /// No description provided for @ai_no_response.
  ///
  /// In en, this message translates to:
  /// **'No response generated'**
  String get ai_no_response;

  /// No description provided for @year_1_2.
  ///
  /// In en, this message translates to:
  /// **'Year 1 & 2'**
  String get year_1_2;

  /// No description provided for @year_3_4.
  ///
  /// In en, this message translates to:
  /// **'Year 3 & 4'**
  String get year_3_4;

  /// No description provided for @tip_network_title.
  ///
  /// In en, this message translates to:
  /// **'Expand Your Network'**
  String get tip_network_title;

  /// No description provided for @tip_network_desc.
  ///
  /// In en, this message translates to:
  /// **'Connect with students from all majors Your university network is your future\'s greatest asset.'**
  String get tip_network_desc;

  /// No description provided for @tip_time_title.
  ///
  /// In en, this message translates to:
  /// **'Master Your Time'**
  String get tip_time_title;

  /// No description provided for @tip_time_desc.
  ///
  /// In en, this message translates to:
  /// **'Learn to balance study, life, and hobbies. Good habits now prevent burnout later.'**
  String get tip_time_desc;

  /// No description provided for @tip_soft_skills_title.
  ///
  /// In en, this message translates to:
  /// **'Focus on Soft Skills'**
  String get tip_soft_skills_title;

  /// No description provided for @tip_soft_skills_desc.
  ///
  /// In en, this message translates to:
  /// **'Work on your communication Sharing your ideas clearly is the key to professional success.'**
  String get tip_soft_skills_desc;

  /// No description provided for @tip_explore_title.
  ///
  /// In en, this message translates to:
  /// **'Explore & Discover'**
  String get tip_explore_title;

  /// No description provided for @tip_explore_desc.
  ///
  /// In en, this message translates to:
  /// **'Don\'t limit yourself to your major, Join clubs, Events and explore new interests outside your field.'**
  String get tip_explore_desc;

  /// No description provided for @tip_professional_title.
  ///
  /// In en, this message translates to:
  /// **'Go Professional'**
  String get tip_professional_title;

  /// No description provided for @tip_professional_desc.
  ///
  /// In en, this message translates to:
  /// **'Start your LinkedIn profile. Connect with experts and observe how your industry operates.'**
  String get tip_professional_desc;

  /// No description provided for @tip_consistent_title.
  ///
  /// In en, this message translates to:
  /// **'Stay Consistent'**
  String get tip_consistent_title;

  /// No description provided for @tip_consistent_desc.
  ///
  /// In en, this message translates to:
  /// **'Small daily efforts beat sudden hard work Build a routine that helps you grow every day.'**
  String get tip_consistent_desc;

  /// No description provided for @tip_experience_title.
  ///
  /// In en, this message translates to:
  /// **'Gain Experience'**
  String get tip_experience_title;

  /// No description provided for @tip_experience_desc.
  ///
  /// In en, this message translates to:
  /// **'Seek any internship or volunteer work Learning \"work culture\" is as vital as the job itself.'**
  String get tip_experience_desc;

  /// No description provided for @tip_problems_title.
  ///
  /// In en, this message translates to:
  /// **'Solve Problems'**
  String get tip_problems_title;

  /// No description provided for @tip_problems_desc.
  ///
  /// In en, this message translates to:
  /// **'Train your mind to find solutions, not just identify issues A proactive attitude wins everywhere.'**
  String get tip_problems_desc;

  /// No description provided for @club_fares_toson_name.
  ///
  /// In en, this message translates to:
  /// **'Fares Toson Academy'**
  String get club_fares_toson_name;

  /// No description provided for @club_fares_toson_desc.
  ///
  /// In en, this message translates to:
  /// **'A professional platform for mastering 3D video editing and motion design, helping you turn creative skills into real income.'**
  String get club_fares_toson_desc;

  /// No description provided for @club_fares_toson_tag.
  ///
  /// In en, this message translates to:
  /// **'3D Video Editing & Monetization'**
  String get club_fares_toson_tag;

  /// No description provided for @club_ieee_name.
  ///
  /// In en, this message translates to:
  /// **'IEEE Student Branch'**
  String get club_ieee_name;

  /// No description provided for @club_ieee_desc.
  ///
  /// In en, this message translates to:
  /// **'Global technical organization for the advancement of technology and innovation.'**
  String get club_ieee_desc;

  /// No description provided for @club_ieee_tag.
  ///
  /// In en, this message translates to:
  /// **'Technical workshops & networking'**
  String get club_ieee_tag;

  /// No description provided for @club_microsoft_name.
  ///
  /// In en, this message translates to:
  /// **'Microsoft Student Club'**
  String get club_microsoft_name;

  /// No description provided for @club_microsoft_desc.
  ///
  /// In en, this message translates to:
  /// **'Global student community dedicated to fostering innovation through Microsoft software and tools.'**
  String get club_microsoft_desc;

  /// No description provided for @club_microsoft_tag.
  ///
  /// In en, this message translates to:
  /// **'Software development'**
  String get club_microsoft_tag;

  /// No description provided for @club_google_name.
  ///
  /// In en, this message translates to:
  /// **'Google Developer Groups'**
  String get club_google_name;

  /// No description provided for @club_google_desc.
  ///
  /// In en, this message translates to:
  /// **'Global community for developers to learn, connect, and build using Google technologies.'**
  String get club_google_desc;

  /// No description provided for @club_google_tag.
  ///
  /// In en, this message translates to:
  /// **'Google technologies & hands-on learning'**
  String get club_google_tag;

  /// No description provided for @club_oi_hub_name.
  ///
  /// In en, this message translates to:
  /// **'Oi HUB'**
  String get club_oi_hub_name;

  /// No description provided for @club_oi_hub_desc.
  ///
  /// In en, this message translates to:
  /// **'Innovation hub connecting students to entrepreneurship and professional career skills.'**
  String get club_oi_hub_desc;

  /// No description provided for @club_oi_hub_tag.
  ///
  /// In en, this message translates to:
  /// **'Innovation hub & career development'**
  String get club_oi_hub_tag;

  /// No description provided for @club_oi_rov_name.
  ///
  /// In en, this message translates to:
  /// **'Oi ROV'**
  String get club_oi_rov_name;

  /// No description provided for @club_oi_rov_desc.
  ///
  /// In en, this message translates to:
  /// **'Technical team dedicated to the design and development of Remotely Operated Vehicles.'**
  String get club_oi_rov_desc;

  /// No description provided for @club_oi_rov_tag.
  ///
  /// In en, this message translates to:
  /// **'Robotics engineering & practical hardware'**
  String get club_oi_rov_tag;

  /// No description provided for @club_icpc_name.
  ///
  /// In en, this message translates to:
  /// **'ICPC OBOUR'**
  String get club_icpc_name;

  /// No description provided for @club_icpc_desc.
  ///
  /// In en, this message translates to:
  /// **'Specialized community focused on algorithmic excellence and competitive programming standards.'**
  String get club_icpc_desc;

  /// No description provided for @club_icpc_tag.
  ///
  /// In en, this message translates to:
  /// **'Problem solving & competitive programming'**
  String get club_icpc_tag;

  /// No description provided for @club_robotics_name.
  ///
  /// In en, this message translates to:
  /// **'ROBOTICS'**
  String get club_robotics_name;

  /// No description provided for @club_robotics_desc.
  ///
  /// In en, this message translates to:
  /// **'Specialized technical community dedicated to the fields of autonomous systems, embedded electronics, and practical robotics design.'**
  String get club_robotics_desc;

  /// No description provided for @club_robotics_tag.
  ///
  /// In en, this message translates to:
  /// **'Hands-on engineering & innovation projects'**
  String get club_robotics_tag;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
