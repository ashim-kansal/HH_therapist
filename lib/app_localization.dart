import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/l10n/messages_all.dart';

class AppLocalizations {
  String get next => Intl.message('Next');
  String get done => Intl.message('Done');
  String get choose_goal => Intl.message('Choose your goal');
  String get video_session => Intl.message('Video Session');
  String get Welcome_back => Intl.message('Welcome back');
  String get login => Intl.message('Login');
  String get enter_password => Intl.message('Enter Password');
  String get pass_validation_msg => Intl.message('Password containes be alpha-numeric with 1 Small, Capital and Special character');
  String get enter_valid_email => Intl.message('Please enter a valid email address');
  String get login_to_existing => Intl.message('Login into your existing account');
  String get forgot_password_ => Intl.message('Forgot Password?');
  String get terms_service => Intl.message('Terms of Service ');
  String get agree_desc => Intl.message('By continuing, you agree to our ');
  String get do_have_acc => Intl.message('Do you have an account ');
  String get signup => Intl.message('Sign Up');
  String get pls_enter_new_pass => Intl.message('Please enter a new password');
  String get enter_new_pass_below => Intl.message('Enter your new password below.');
  String get enter_new_pass => Intl.message('Enter New Password');
  String get drinking_diary_progress => Intl.message('Daily drinking diary to track your progress');
  String get join_therapist_direct => Intl.message('Join your therapist directly from your phone');
  String get to_help_triggers => Intl.message('To help you understand your triggers');
  String get valid_confirm_pass => Intl.message('Please enter a valid confirm password');
  String get valid_otp_msg => Intl.message('Please enter the valid OTP');
  String get reset => Intl.message('Reset');
  String get alert => Intl.message('Alert');
  String get password_donotmatch => Intl.message('Passwords do not matched.');

  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
  String get heyWorld => Intl.message('Hey World');
  String get abc => Intl.message('abc',
      name: 'abc',
      desc: 'Simpel word for greeting ');
  String get selectLang => Intl.message('Select Language');
  String get hh => Intl.message('Heal@Home Programs');
  String get pls_enter_reg_email => Intl.message('Please enter you registered email address. We will help you retrieve your password.');
  String get terms => Intl.message('Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.');
  String get programHeading => Intl.message('Alcohol Management Program');
  String get program => Intl.message("6 MONTH PROGRAM");
  String get program_ => Intl.message("Program");
  String get proceed => Intl.message("Proceed");
  String get settings => Intl.message("Settings");
  String get enter_email => Intl.message("Enter Email");
  String get select_language => Intl.message("Select Language");
  String get change_password => Intl.message("Change Password");
  String get forgot_password => Intl.message("Forgot Password");
  String get reset_password => Intl.message("Reset Password");
  String get change_language => Intl.message("Change Language");
  String get emailExist => Intl.message("Email already exist!");
  String get emailExistDesc => Intl.message("We found an account with this email, do you want to login?");
  String get sample_ques => Intl.message("Lorem Ipsum is simply dummy text of the printing and typesetting industry?");
  String get feedbackTitle => Intl.message("Feedback");
  String get ABOUT_US => Intl.message("ABOUT_US");
  String get error => Intl.message("Error");
  String get submit => Intl.message("Submit");
  String get save => Intl.message("save");
  String get chat => Intl.message("Chat");
  String get mychat => Intl.message("My Chats");
  String get dashboard => Intl.message("Dashboard");
  String get no_msg => Intl.message("No New Messages");
  String get not_found => Intl.message("Not Found");
  String get not_data_found => Intl.message("No Data Found");
  String get my_programs => Intl.message("My Programs");
  String get please_share_thoughts => Intl.message("Please share your thoughts with us");
  String get please_contact_us => Intl.message("Please use this form to connect us ");
  String get please_enter_feedback => Intl.message("Please enter a feedback");
  String get please_enter_review => Intl.message("Please enter your review");
  String get no_record_found => Intl.message("No Record Found");
  String get schedule => Intl.message("Schedule");
  String get Upcoming => Intl.message("Upcoming");
  String get Completed => Intl.message("Completed");
  String get send => Intl.message("Send");
  String get no_up_sessions => Intl.message("No Upcoming Sessions");
  String get viewall => Intl.message("View All");
  String get drinking_diary => Intl.message("Drinking Diary");
  String get dailyjournaling => Intl.message("Daily Journaling");
  String get mysession => Intl.message("My Session");
  String get upcoming_sessions => Intl.message("Upcoming Sessions");
  String get Settings => Intl.message("Settings");
  String get search_pharma => Intl.message("Search Nearest Pharmacies");
  String get open => Intl.message("Open");
  String get cancel => Intl.message("Cancel");
  String get Notification => Intl.message("Notification");
  String get Notifications => Intl.message("Notifications");
  String get UpgradeNow => Intl.message("Upgrade Now");
  String get Journaling => Intl.message("Journaling");
  String get NewJournal => Intl.message("New Journal");
  String get oldJournal => Intl.message("Old Journal");
  String get Support => Intl.message("Support");
  String get home => Intl.message("Home");
  String get library => Intl.message("Library");
  String get assessment => Intl.message("Assessment");
  String get therapists => Intl.message("Therapists");
  String get address => Intl.message("Address");
  String get fname => Intl.message("First Name");
  String get lname => Intl.message("Last Name");
  String get name => Intl.message("Name");
  String get edit => Intl.message("Edit");
  String get submit_proceed => Intl.message("Submit & Proceed");
  String get phone_number => Intl.message("Phone Number");
  String get email => Intl.message("Email");
  String get Update => Intl.message("Update");
  String get share_reviews => Intl.message("Share Your Reviews");
  String get Questionaire => Intl.message("Questionaire");
  String get Profile => Intl.message("Profile");
  String get FAQ => Intl.message("FAQ's");
  String get edit_profile => Intl.message("Edit Profile");
  String get Contact_Us => Intl.message("Contact Us");
  String get more_info => Intl.message("More Information");
  String get about_us => Intl.message("About Us");
  String get tnc => Intl.message("Terms & Conditions");
  String get privacy => Intl.message("Privacy Policy");
  String get logout => Intl.message("Log Out");
  String get tems_condi => Intl.message("Terms & Condition");
  String get my_therapists => Intl.message("My Therapists");
  String get otp_verification => Intl.message("OTP Verification");
  String get resend_code => Intl.message("Resend code in:");
  String get Therapist => Intl.message("Therapist");
  String get Resend_OTP => Intl.message("Resend OTP");
  String get get_started => Intl.message("Get Started");
  String get Physician => Intl.message("Physician");
  String get case_manager => Intl.message("Case manager");
  String get reschedule => Intl.message("Re-Schedule");
  String get old_password => Intl.message("Old Password");
  String get new_password => Intl.message("New Password");
  String get confirm_password => Intl.message("Confirm Password");
  String get enter_msg => Intl.message("Enter message");
  String get confPasswordErrorMsg => Intl.message("Please enter a confirm password");

}



class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations>{

  final Locale overriddenLocale;
  const AppLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => ['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;

}