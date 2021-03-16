import 'package:flutter/material.dart';
import 'package:talawa/services/Queries.dart';
import 'package:talawa/services/preferences.dart';
import 'package:talawa/utils/apiFuctions.dart';

class RegisterdEvents extends StatefulWidget {
  Map member;

  RegisterdEvents({
    Key key,
    @required this.member,
  }) : super(key: key);

  @override
  _RegisterdEventsState createState() => _RegisterdEventsState();
}

class _RegisterdEventsState extends State<RegisterdEvents> {
  Preferences preferences = Preferences();

  ApiFunctions apiFunctions = ApiFunctions();
  List userEvents = [];

  void initState() {
    super.initState();
    getUserDetails();
  }

  getUserDetails() async {
    final String userID = widget.member['_id'];
    Map result =
        await apiFunctions.gqlquery(Queries().registeredEventsByUser(userID));
    // print(result);
    setState(() {
      userEvents = result == null ? [] : result['registeredEventsByUser'];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userEvents.length != 0) {
      if (userEvents[0]['title'] == null) {
        userEvents = [];
      }
    }
    return userEvents.length != 0
        ? ListView.builder(
            itemCount: userEvents.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text('${userEvents[index]['title']}'),
              );
            })
        : Container(
            child: Center(
                child: Text(
              "No registered events",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            )),
          );
  }
}
