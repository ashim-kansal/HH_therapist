import 'package:flutter/material.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/api/StaticContent.dart';
import 'package:flutter_app/model/StaticContentModel.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class TermsPage extends StatefulWidget {
  static const String RouteName = '/terms';

  TermsPage({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<TermsPage> {


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
    MyWidget(title: AppLocalizations.of(context).tnc,
      child: SingleChildScrollView(
        child: FutureBuilder<StaticContent>(
                          future: getStaticContent("TERMS"),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              if(snapshot.hasError){
                                return Center(child: Text(AppLocalizations.of(context).error),);
                              }
                              return  Container(
                                // height: MediaQuery.of(context).size.height,
                                  child: Html(

                                    data:snapshot.data.result.description,
                                    // style: {
                                    //   "div": Style(
                                    //       color: HH_Colors.color_707070,
                                    //       fontSize: FontSize(15.0)
                                    //   ),"p": Style(
                                    //       color: HH_Colors.color_707070,
                                    //       fontSize: FontSize(15.0)
                                    //   ),
                                    // },
                                    // style: TextStyle(fontSize: 16, color: HH_Colors.grey_707070),
                                  )


                              );
                            }else
                              return Container(
                                child: Center(child: CircularProgressIndicator(),),
                              );
                          },
                        ),
      )
    
    );
  
  }
}
