import 'package:flutter/material.dart';
import 'package:flutter_app/screens/book_session.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/tharapist_cell.dart';

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
    return ListView.separated(
      itemCount: widget.users.length,
      itemBuilder: (context, index) {
        return ChatUserCell(
          name: widget.users[index],
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
  }
}
