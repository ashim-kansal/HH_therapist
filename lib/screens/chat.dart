import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/model/ChatList.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/message.dart';
import 'package:flutter_app/widgets/message_widget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:intl/intl.dart';
import 'package:simple_moment/simple_moment.dart';

class ChatPage extends StatefulWidget {
  static const String RouteName = '/chat';

  String chatId;
  String senderId;
  ChatPage({Key key, this.title, this.chatId, this.senderId}) : super(key: key);
  String title;

  @override
  _ChatPageState createState() => new _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // final List<Message> _messages = <Message>[];

  Future messagesList;
  String receiverId;
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final _textController = TextEditingController();

   @override
  void initState() {
    super.initState();
    // messagesList = getChatList(widget.chatId);
  }

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(time);

    return new MyWidget(
      title: 'Chat',
        child: new Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: new Container(
              child: new Column(
                children: <Widget>[
                  //Chat list
                  FutureBuilder<ChatList>(
                    future: getChatList(widget.chatId),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.done){
                        if(snapshot.hasError){
                          return  HHTextView(title: "No Record Found", size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600,);
                        }
                        var item = snapshot.data.result;
                        return  new Flexible(
                          child: new ListView.builder(
                            padding: new EdgeInsets.all(8.0),
                            // reverse: true,
                            itemBuilder: (context, int index) {
                              receiverId = item[0].senderId.id;
                              // return ListView.builder(itemBuilder: (context, qindex){
                                var _date = item[0].message[index].createdAt;
                                Moment createdDt = Moment.parse('$_date');
                                return MessageWidget(
                                  msg: item[0].message[index].message,
                                  direction: item[0].message[index].senderId == widget.senderId ? "left" : "right",
                                  dateTime: createdDt.format("dd MMM, yyyy hh:mm a"),
                                );
                              // });
                            },
                            itemCount: item[0].message.length,
                          ),
                        );
                      }else {
                        return Container(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                  ),
                 
                  new Divider(height: 1.0),
                  new Container(
                      decoration:
                      new BoxDecoration(color: Theme.of(context).cardColor),
                      child: new IconTheme(
                          data: new IconThemeData(
                              color: Theme.of(context).accentColor),
                          child: new Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                //left send button
                                new Flexible(
                                  child: new TextField(
                                    controller: _textController,
                                    decoration: new InputDecoration.collapsed(
                                        hintText: "Enter message"
                                    ),
                                  ),
                                ),

                                new Container(

                                  child: new IconButton(
                                      icon: Image.asset(
                                          "assets/images/ic_chat_send.png"),
                                      onPressed: () => _sendMsg(
                                          _textController.text,
                                          'right',
                                          formattedDate)),
                                ),

                                //Enter Text message here

                                //right send button

                                // new Container(
                                //   margin:
                                //   new EdgeInsets.symmetric(horizontal: 2.0),
                                //   width: 48.0,
                                //   height: 48.0,
                                //   child: new IconButton(
                                //       icon: Image.asset(
                                //           "assets/images/send_out.png"),
                                //       onPressed: () => _sendMsg(
                                //           _textController.text,
                                //           'right',
                                //           formattedDate)),
                                // ),
                              ],
                            ),
                          ))),
                ],
              ),
            )));
  }

  void _sendMsg( String msg, String messageDirection, String date) {
    if (msg.trim().length == 0) {
      return;
      // Fluttertoast.showToast(
      //     msg: "Please Enter Message",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIos: 1,
      //     backgroundColor: Colors.blue);
    } else {

      MessageWidget messageWidget = new MessageWidget(
        msg: msg,
        direction: messageDirection,
        dateTime: date,
      );

      InAppAPIServices inAppAPIServices = new InAppAPIServices();

      inAppAPIServices.sendMessage(receiverId, msg).then((value) => {
        if(value.responseCode == 200){
          _textController.clear(),
          messagesList = getChat(),
          Navigator.pop(context)
          //  setState(() {
          //   // messageWidget.insert(0, messageWidget);
          // })
        }
      });

    }
  }




  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    // Clean up the controller when the Widget is disposed
    _textController.dispose();
    super.dispose();
  }
}

class ChatArguments {
  final String chatId;
  final String senderId;

  ChatArguments(this.chatId, this.senderId);
}