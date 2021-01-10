import 'package:flutter/material.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/model/ClientListing.dart';
import 'package:flutter_app/screens/book_session.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/tharapist_cell.dart';

class TherapistPage extends StatefulWidget {
  static const String RouteName = '/therapists';
  // final String title;
  var error = false;

  @override
  _TherapistState createState() => _TherapistState();
}

class _TherapistState extends State<TherapistPage> {
  @override
  Widget build(BuildContext context) {
    return MyWidget( title: AppLocalizations.of(context).mychat,
      child: FutureBuilder<MyClientList>(
        future: getMyClientList(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasError){
              return HHTextView(title: AppLocalizations.of(context).no_record_found, size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600,);
            }

          return ListView.separated(
            itemCount: snapshot.data.result.myPatient.length,
              itemBuilder: (context, index) {
                return TharapistCell(
                  name: snapshot.data.result.myPatient[index].firstName+" "+snapshot.data.result.myPatient[index].lastName,
                  image: snapshot.data.result.myPatient[index].profilePic,
                  role: "",
                  showBook: false,
                  patientid: snapshot.data.result.myPatient[index].id,
                  onClick: () {
                    Navigator.pushNamed(context, BookSessionPage.RouteName);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider(color: HH_Colors.accentColor,);
              },
            );
          }else {
            return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
          }
        },
      )
    );
  }
}

