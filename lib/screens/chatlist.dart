import 'package:flutter/material.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/model/ChatList.dart';
import 'package:flutter_app/screens/book_session.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/tharapist_cell.dart';
import 'package:simple_moment/simple_moment.dart';

class ChatListPage extends StatefulWidget {
  static const String RouteName = '/chat_users';
  final users = [
    'abcd',
    'abcd',
    'abcd',
    'abcd',
    'abcd',
    'abcd',
  ];

  ChatListPage({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ChatList>(
      future: getChatList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if(snapshot.hasError){
            return HHTextView(title: "No new messages", size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600,);
          }
          return ListView.separated(
            itemCount: snapshot.data.result.length,
            itemBuilder: (context, index) {
              var item = snapshot.data.result[index];
              var _date = item.message[item.message.length - 1].createdAt;
              Moment createdDt = Moment.parse('$_date');
              return ChatUserCell(
                name: item.senderId.firstName+" "+item.senderId.lastName,
                message: item.message[item.message.length - 1].message,
                profile: item.senderId.profilePic,
                time: createdDt.format("hh:mm a"),
                online: true,
                onClick: () {
                  Navigator.pushNamed(context, ChatPage.RouteName);
                },
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          );
        }else {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
