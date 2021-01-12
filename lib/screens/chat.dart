import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/model/ChatList.dart';
import 'package:flutter_app/utils/Utils.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/message_widget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:intl/intl.dart';
import 'package:simple_moment/simple_moment.dart';

class ChatPage extends StatefulWidget {
  static const String RouteName = '/chat';

  String senderId;
  ChatPage({Key key, this.title, this.senderId}) : super(key: key);
  String title;

  @override
  _ChatPageState createState() => new _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // final List<Message> _messages = <Message>[];
  final ScrollController _scrollController = ScrollController();
  List<Message> message;
  Result _user;

  Future messagesList;
  String receiverId;
  final _textController = TextEditingController();

   @override
  void initState() {
    super.initState();
    messagesList = getChat();
  }

  getChat() async {
    return await getChatList(widget.senderId).then((value) => {
      if(value.responseCode == 200){
        setState((){
          _user = value.result.length > 0 ? value.result[0] : null;
          message = value.result[0].message;
        })
      }
    });

  }
  _scrollToEnd() async {
    if(_scrollController.hasClients)
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }
  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(time);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());

    return new MyWidget(
      title: AppLocalizations.of(context).chat,
        child: new Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: new Container(
              child: new Column(
                children: <Widget>[
                          new Flexible(
                            child:(message??List()).length > 0 ? new ListView.builder(
                              padding: new EdgeInsets.all(8.0),
                              controller: _scrollController,
                              itemBuilder: (context, int index) {
                                receiverId = _user.senderId.id;
                                var _date = message[index].createdAt;
                                Moment createdDt = Moment.parse('$_date');
                                return MessageWidget(
                                  msg: message[index].message,
                                  direction: message[index].senderId != widget.senderId ? "left" : "right",
                                  dateTime: createdDt.format("dd MMM, yyyy hh:mm a"),
                                );
                              },
                              itemCount: (message??List()).length,
                            ) : Center(child: Text(AppLocalizations.of(context).no_msg),),
                          ),
                 
                  new Divider(height: 1.0),
                  new Container(
                    
                      decoration: new BoxDecoration(color: Theme.of(context).cardColor),
                      child: new IconTheme(
                              data: new IconThemeData(color: Theme.of(context).accentColor),
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
                                            hintText: AppLocalizations.of(context).enter_msg
                                        ),
                                      ),
                                    ),

                                    new Container(
                                      child: new IconButton(
                                          icon: Image.asset(
                                              "assets/images/ic_chat_send.png"),
                                          onPressed: () => _sendMsg(context,
                                              _textController.text,
                                              'right',
                                              formattedDate)),
                                    ),
                                  ],
                                ),
                              )
                            ),
                        
                      ),
                ],
              ),
            )));
  }

  void _sendMsg(BuildContext context, String msg, String messageDirection, String date) {

    if (msg.trim().length == 0) {

      showToast(context,
          "Please Enter Message");
      return;
    }

    MessageWidget messageWidget = new MessageWidget(
      msg: msg,
      direction: messageDirection,
      dateTime: date,
    );

    InAppAPIServices inAppAPIServices = new InAppAPIServices();

    inAppAPIServices.sendMessage(widget.senderId, msg).then((value) => {

      print(receiverId),
      print(msg),
      if(value.responseCode == 200){
        _textController.clear(),
        // messagesList = getChat(),
        // Navigator.pop(context),
        // chatLists = getChat(),
        setState(() {
          message = value.result.message;
          _user = value.result;
          // messageWidget.insert(0, messageWidget);
        }),
        _scrollToEnd()

      }
    });
  }


  getChata() async {
    return await getChatList(widget.senderId);
  }


  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    // Clean up the controller when the Widget is disposed
    _textController.dispose();
    super.dispose();
  }

  // getChat() async{
  //   return await getChatList(widget.chatId);
  // }

}

class ChatArguments {
  final String senderId;

  ChatArguments(this.senderId);
}