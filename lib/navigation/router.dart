import 'package:flutter/material.dart';
import 'package:flutter_app/ChangeLanguage.dart';
import 'package:flutter_app/forgotpasswrd.dart';
import 'package:flutter_app/goals.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/otp.dart';
import 'package:flutter_app/resetpassword.dart';
import 'package:flutter_app/screens/Notes.dart';
import 'package:flutter_app/screens/aboutus.dart';
import 'package:flutter_app/screens/assessment.dart';
import 'package:flutter_app/screens/assessment_form.dart';
import 'package:flutter_app/screens/book_session.dart';
import 'package:flutter_app/screens/change_password.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:flutter_app/screens/chatlist.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/screens/drinking_diary.dart';
import 'package:flutter_app/screens/feedback.dart';
import 'package:flutter_app/screens/journal.dart';
import 'package:flutter_app/screens/language.dart';
import 'package:flutter_app/screens/sessions.dart';
import 'package:flutter_app/screens/settings.dart';
import 'package:flutter_app/screens/tharapist.dart';
import 'package:flutter_app/splash.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/screens/editProfile.dart';
import 'package:flutter_app/screens/profile.dart';
import 'package:flutter_app/screens/review.dart';
import 'package:flutter_app/screens/notification.dart';
import 'package:flutter_app/screens/sessionsDetails.dart';
import 'package:flutter_app/widgets/sessionWidgets.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Splash.RouteName:
      return MaterialPageRoute(builder: (context) => Splash());
    case SelectLanguage.RouteName:
      return MaterialPageRoute(builder: (context) => SelectLanguage());
    case LoginPage.RouteName:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case ForgotPasswordPage.RouteName:
      return MaterialPageRoute(builder: (context) => ForgotPasswordPage());
    case OtpPage.RouteName:
      return MaterialPageRoute(builder: (context) => OtpPage());
    case ResetPasswordPage.RouteName:
      return MaterialPageRoute(builder: (context) => ResetPasswordPage());
    case DrinkingDiaryPage.RouteName:
      return MaterialPageRoute(builder: (context) => DrinkingDiaryPage());
    case Dashboard.RouteName:
      return MaterialPageRoute(builder: (context) => Dashboard());
    case TherapistPage.RouteName:
      final ScreenArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => TherapistPage());
    case BookSessionPage.RouteName:
      final SessionArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => BookSessionPage(id: args.id, name: args.name, image: args.profilePic, role: args.type, sessionId: args.sessionId,));
    case MyAssessmentPage.RouteName:
      return MaterialPageRoute(builder: (context) => MyAssessmentPage());
    case SessionPage.RouteName:
      return MaterialPageRoute(builder: (context) => SessionPage());
    case ChatListPage.RouteName:
      return MaterialPageRoute(builder: (context) => ChatListPage());
    case JournalPage.RouteName:
      return MaterialPageRoute(builder: (context) => JournalPage());
    case EditProfilePage.RouteName:
      return MaterialPageRoute(builder: (context) => EditProfilePage());
    case ProfilePage.RouteName:
      return MaterialPageRoute(builder: (context) => ProfilePage());
    case ReviewPage.RouteName:
      return MaterialPageRoute(builder: (context) => ReviewPage());
    case SettingsPage.RouteName:
      return MaterialPageRoute(builder: (context) => SettingsPage());
    case FeedbackPage.RouteName:
      return MaterialPageRoute(builder: (context) => FeedbackPage());
    case LanguagePage.RouteName:
      final LanguageArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => LanguagePage(languagedata: args.language));
    case NotificationPage.RouteName:
      return MaterialPageRoute(builder: (context) => NotificationPage());
    case ChnagePasswordPage.RouteName:
      return MaterialPageRoute(builder: (context) => ChnagePasswordPage());
    case ChatPage.RouteName:
      return MaterialPageRoute(builder: (context) => ChatPage());
    case SessionDetails.RouteName:
      return MaterialPageRoute(builder: (context) => SessionDetails());
    case NotesPage.RouteName:
      return MaterialPageRoute(builder: (context) => NotesPage());
    case AssessmentFormPage.RouteName:
      final ScreenArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => AssessmentFormPage(title: args.title, enable: args.completed?true:false,));
    case AboutUs.RouteName:
      final ScreenArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => AboutUs(title: args.title));
    default:
      return MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name));
  }
}