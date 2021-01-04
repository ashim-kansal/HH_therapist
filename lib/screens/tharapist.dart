import 'package:flutter/material.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/model/ClientListing.dart';
import 'package:flutter_app/screens/assessment_form.dart';
import 'package:flutter_app/screens/book_session.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/tharapist_cell.dart';

class TherapistPage extends StatefulWidget {
  static const String RouteName = '/therapists';
  final therapists = [
    'Rejina Freak',
    'Rejina Freak',
    'Rejina Freak',
    'Rejina Freak',
    'Rejina Freak',
    'Rejina Freak',
  ];

  // TherapistPage({Key key, this.title}) : super(key: key);

  // final String title;
  var error = false;

  @override
  _TherapistState createState() => _TherapistState();
}

class _TherapistState extends State<TherapistPage> {
  @override
  Widget build(BuildContext context) {
    return MyWidget( title: 'My Clients',
      child: FutureBuilder<MyClientList>(
        future: getMyClientList(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasError){
              return HHTextView(title: "No Record Found", size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600,);
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

class TherapistlOverlay extends ModalRoute<Widget> {
  static const String RouteName = '/select_therapist';

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'This is a nice overlay',
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
          RaisedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Dismiss'),
          )
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

class TherapistOptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child:         ListView(
        padding: EdgeInsets.all(40),
        children:[
          Center(child: TherapistOptionItem(title: 'Therapist', image: 'assets/images/ic_therapist.png', onClick: (){
            Navigator.pushNamed(context, TherapistPage.RouteName, arguments: ScreenArguments('Therapist',false));
          },) ),
          SizedBox(height: 50,),
          Center(child: TherapistOptionItem(title: 'Physician', image: 'assets/images/ic_physician.png', onClick: (){
            Navigator.pushNamed(context, TherapistPage.RouteName, arguments: ScreenArguments('Physician',false));

          }),),
          SizedBox(height: 50,),
          Center(child: TherapistOptionItem(title: 'Case manager', image: 'assets/images/ic_case_manager.png', onClick: (){

          }),),
    ]),

    );
  }
}

class TherapistOptionItem extends StatelessWidget {
  var image;
  var title = "";
  final VoidCallback onClick;

  TherapistOptionItem(
      {@required this.title, @required this.image, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 10,
      child: InkWell(
        child: Container(
          width: MediaQuery.of(context).size.width/2.2,
          height: MediaQuery.of(context).size.width/2.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                image,
                height: 70,
                width: 70,
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(fontSize: 20, color: HH_Colors.grey_3d3d3d),
              ),
            ],
          ),
        ),
        onTap: (){
          onClick();
        },
      ),
    );
  }
}
