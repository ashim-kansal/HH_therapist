import 'package:flutter/material.dart';
import 'package:flutter_app/ChangeLanguage.dart';
import 'package:flutter_app/forgotpasswrd.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/model/UpcomingSessionsModel.dart';
import 'package:flutter_app/otp.dart';
import 'package:flutter_app/resetpassword.dart';
import 'package:flutter_app/screens/Notes.dart';
import 'package:flutter_app/screens/assessment_form.dart';
import 'package:flutter_app/screens/book_session.dart';
import 'package:flutter_app/screens/change_password.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:flutter_app/screens/chatlist.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/screens/editProfile.dart';
import 'package:flutter_app/screens/feedback.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/language.dart';
import 'package:flutter_app/screens/notification.dart';
import 'package:flutter_app/screens/profile.dart';
import 'package:flutter_app/screens/review.dart';
import 'package:flutter_app/screens/sessions.dart';
import 'package:flutter_app/screens/sessionsDetails.dart';
import 'package:flutter_app/screens/settings.dart';
import 'package:flutter_app/screens/tharapist.dart';
import 'package:flutter_app/splash.dart';
import 'package:flutter_app/twilio/conference/conference_page.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
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
    case Dashboard.RouteName:
      return MaterialPageRoute(builder: (context) => Dashboard());
    case TherapistPage.RouteName:
      return MaterialPageRoute(builder: (context) => TherapistPage());
    case BookSessionPage.RouteName:
      final SessionArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => BookSessionPage(id: args.id, name: args.name, image: args.profilePic, role: args.type, sessionId: args.sessionId,));
   case SessionPage.RouteName:
      return MaterialPageRoute(builder: (context) => SessionPage());
    case ChatListPage.RouteName:
      return MaterialPageRoute(builder: (context) => ChatListPage());
    case EditProfilePage.RouteName:
      final ProfileArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => EditProfilePage(data: args.data));
      // return MaterialPageRoute(builder: (context) => EditProfilePage());
    case ProfilePage.RouteName:
      return MaterialPageRoute(builder: (context) => ProfilePage());
    case ReviewPage.RouteName:
      final Result result = settings.arguments;
      return MaterialPageRoute(builder: (context) => ReviewPage(data:result));
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
      final ChatArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => ChatPage(senderId: args.senderId));
    case VideoCallPage.RouteName:
      final VideoPageArgument args = settings.arguments;
      return MaterialPageRoute(builder: (context) => VideoCallPage(token: args.token,roomName: args.roomName,identity: args.identity,));
    case SessionDetails.RouteName:
      final SessionDetailsArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => SessionDetails(sessionId: args.data, patientId: args.patientId,));
    case NotesPage.RouteName:
      final NotesArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => NotesPage(patientId: args.data));
    case AssessmentFormPage.RouteName:
      final AssessmentArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => AssessmentFormPage(id: args.id));
    default:
      return MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name));
  }
}