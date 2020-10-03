import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/sample_order_data.dart';

class CountDownTimer extends StatefulWidget {
  CountDownTimer({
    Key key,
    this.seconds,
    this.text,
    this.orderId,
    this.whenTimeExpires,
    this.leftTime,
  }) : super(key: key);

  final int seconds;
  final String text;
  final int orderId;
  final DateTime leftTime;
  final Function whenTimeExpires;

  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  int _seconds;
  Timer _timer;

  @override
  void initState() {
    _seconds = widget.seconds;
    if (widget.leftTime != null && _seconds > 0) {
      int diff = DateTime.now().difference(widget.leftTime).inSeconds;
      if (diff > _seconds)
        _seconds = 0;
      else
        _seconds -= diff;
    }
    _countDown();
    super.initState();
  }

  String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  String get timerDisplayString {
    if (_seconds >= 0) {
      Provider.of<SampleData>(
        context,
        listen: false,
      ).updateTimer(widget.orderId, _seconds);
    }
    return formatHHMMSS(_seconds);
  }

  void _countDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds <= 0) {
          _timer.cancel();
          widget.whenTimeExpires();
        } else {
          _seconds -= 1;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '${widget.text} ($timerDisplayString)',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
