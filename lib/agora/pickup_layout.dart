import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/agora/pickup_screen.dart';

import 'call.dart';
import 'call_methods.dart';

class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  final String myId;
  final CallMethods callMethods = CallMethods();

  PickupLayout({
    @required this.scaffold,@required this.myId,
  });

  @override
  Widget build(BuildContext context) {

    return (myId != null)
        ? StreamBuilder<DocumentSnapshot>(
            stream: callMethods.callStream(uid: myId),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.data() != null) {
                Call call = Call.fromMap(snapshot.data.data());

                if (!call.hasDialled) {
                  return PickupScreen(call: call, myId: myId,);
                }
              }
              return scaffold;
            },
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
