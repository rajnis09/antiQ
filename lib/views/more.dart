import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../routes/routes.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  bool _isOnline = false;
  String _status = "Offline";
  String _statusOff = "Offline";
  String _statusOn = "Accepting Orders";
  String _schedule = "Not scheduled yet!";
  String _notScheduled = "Not scheduled yet!";
  Color tempColor = Color.fromRGBO(128, 128, 128, 1);
  TimeOfDay _time = new TimeOfDay.now();
  DateTime duration;
  int minDiff;
  int secDiff;

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if (picked != null && picked != _time) {
      setState(() {
        duration = DateTime.now();
        _time = picked;
        _schedule = "scheduled at: " +
            _time.hour.toString() +
            ":" +
            _time.minute.toString();
        minDiff = _time.minute - duration.minute - 1;
        secDiff = 60 - duration.second;
      });

      Timer(
          Duration(
            hours: _time.hour - duration.hour,
            minutes: minDiff,
            seconds: secDiff,
          ), () {
        setState(() {
          _isOnline = !_isOnline;
          _schedule = _notScheduled;
          if (_isOnline) {
            _status = _statusOn;
            tempColor = Color.fromRGBO(34, 139, 34, 1);
          }

          if (!_isOnline) {
            _status = _statusOff;
            tempColor = Color.fromRGBO(128, 128, 128, 1);
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: AppBar().preferredSize.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      _status,
                      style: TextStyle(color: Colors.black87, fontSize: 20),
                    ),
                  ),
                  CupertinoSwitch(
                    value: _isOnline,
                    activeColor: tempColor,
                    onChanged: (value) {
                      setState(() {
                        _isOnline = value;
                        if (value) {
                          _status = _statusOn;
                          tempColor = Color.fromRGBO(34, 139, 34, 1);
                        }

                        if (!value) {
                          _status = _statusOff;
                          tempColor = Color.fromRGBO(128, 128, 128, 1);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.profilePage,
                    arguments: [true, true, false]);
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage('assets/images/restaurant.png'),
                  ),
                  title: Text(
                    'Happy Foods!',
                    style: TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    'The Indian Cuisine',
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.schedule,
                    size: 35,
                  ),
                  title: Text(
                    'Schedule Ordering in Advance',
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(_schedule),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.orderHistory);
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: ListTile(
                  title: Text('Order History', style: TextStyle(fontSize: 20)),
                  leading: Icon(
                    Icons.history,
                    size: 35,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
