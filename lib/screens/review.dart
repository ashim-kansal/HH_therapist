import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/model/UpcomingSessionsModel.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/Utils.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class ReviewPage extends StatefulWidget {
  static const String RouteName = '/review';

  final Result data;

  ReviewPage({Key key, this.data}) : super(key: key);

  var error = false;

  @override
  State<StatefulWidget> createState() => ReviewState();
}

class ReviewState extends State<ReviewPage> {

  String comments = '';
  TextEditingController reviewController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    reviewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return new MyWidget(
        // title: AppLocalizations.of(context).share_reviews,
        title: 'Shave Review',
        child: new Container(
          child: new Column(
            children: <Widget>[

              Flexible(

                  child: Column(children: [

                    Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(3.0),

                        child: Column(children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: HHTextView(
                              title: widget.data.programName,
                              size: 16,
                              color: HH_Colors.accentColor,
                              textweight: FontWeight.w400,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            alignment: Alignment.topLeft,
                            child:HHTextView(
                                title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                size: 14,
                                color: Color(0xff707070)
                            ),
                          )
                        ],)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(3.0),

                        child: Column(children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: HHEditText(
                              hint: "",
                              controller: reviewController,
                              error: widget.error,
                              errorText:'Please enter Review',
                              textarea: true,
                              minLines: 4,
                              onSelectAnswer:  (text){
                                setState(() {
                                  comments = text;
                                });
                              },
                            ),
                          ),

                        ],)
                    ),
                  ],)
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 50, 5, 15),
                  child: HHButton(
                    isEnable: true,
                    title: 'submit',
                    type: 4,
                    onClick: () {
                      submitReview(widget.data.id, comments);
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }

  submitReview(sessionId, comments){
    submitSessionReview(sessionId, comments).then((value) => {
      if(value.responseCode == 200){
        showToast(context, value.responseMessage),
        Navigator.pop(context)
      }
    });
  }
}
