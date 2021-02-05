import 'package:flutter/material.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/model/ChatList.dart';
import 'package:flutter_app/screens/book_session.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/tharapist_cell.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ChatListPage extends StatefulWidget {
  static const String RouteName = '/chat_users';

  ChatListPage({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<ChatList>(
        future: getChatList(null),
        builder: (context, snapshot) {
          initializeDateFormatting();
          if (snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasError){
              return Container(
                child: Center(
                  child: HHTextView(title: AppLocalizations.of(context).no_msg, size: 18, color: HH_Colors.purpleColor, textweight: FontWeight.w600,),
                ),
              );
            }
            return ListView.separated(
              itemCount: snapshot.data.result.length,
              itemBuilder: (context, index) {
                var item = snapshot.data.result[index];
                var _date = item.message[item.message.length - 1].createdAt;
                Moment createdDt = Moment.parse('$_date');
                return ChatUserCell(
                  name: item.receiverId.firstName+" "+item.receiverId.lastName,
                  message: item.message[item.message.length - 1].message,
                  profile: item.receiverId.profilePic,
                  time: createdDt.format("hh:mm a"),
                  online: true,
                  onClick: () {
                    Navigator.pushNamed(context, ChatPage.RouteName, arguments: ChatArguments(item.receiverId.id));
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
      ),
    );
  }
}
