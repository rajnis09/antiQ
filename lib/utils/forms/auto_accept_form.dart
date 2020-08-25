import 'package:flutter/material.dart';

enum RadioValues { hour2, hour4, other }
List<String> months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

class AutoAcceptForm extends StatefulWidget {
  @override
  _AutoAcceptFormState createState() => _AutoAcceptFormState();
}

class _AutoAcceptFormState extends State<AutoAcceptForm> {
  var _show = false;
  DateTime _date;
  TimeOfDay _time;
  var _value = RadioValues.hour2;

  String getDate() {
    if (_date == null)
      setState(() {
        _date = DateTime.now();
      });
    String day = _date.day < 10 ? '0${_date.day}' : '${_date.day}';
    return '$day - ${months[_date.month]}, ${_date.year}';
  }

  String getTime() {
    if (_time == null)
      setState(() {
        _time = TimeOfDay.now();
      });

    String hr =
        _time.hour < 10 ? '0${_time.hourOfPeriod}' : '${_time.hourOfPeriod}';
    String mn = _time.minute < 10 ? '0${_time.minute}' : '${_time.minute}';
    return '$hr : $mn ${_time.period.index == 0 ? "AM" : "PM"}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Turn on Auto-accept',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        leading: null,
        
        // leadingWidth: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(false),
          )
        ],
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          RadioListTile<RadioValues>(
            value: RadioValues.hour2,
            groupValue: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
                _show = false;
              });
            },
            title: Text('After 2 hours'),
          ),
          RadioListTile<RadioValues>(
            value: RadioValues.hour4,
            groupValue: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
                _show = false;
              });
            },
            title: Text('After 4 hours'),
          ),
          RadioListTile<RadioValues>(
            value: RadioValues.other,
            groupValue: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
                _show = true;
              });
            },
            title: Text('Specific Date & Time'),
          ),
          if (_show)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _drawColumn(
                    'Date',
                    getDate(),
                    () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          Duration(
                            days: 365,
                          ),
                        ),
                      ).then(
                        (date) {
                          setState(() {
                            if (date == null)
                              _date = DateTime.now();
                            else
                              _date = date;
                          });
                        },
                      );
                    },
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  _drawColumn(
                    'Time',
                    getTime(),
                    () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then(
                        (time) => {
                          setState(() {
                            if (time == null)
                              _time = TimeOfDay.now();
                            else
                              _time = time;
                          })
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          RaisedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Apply'),
          )
        ],
      ),
    );
  }

  Widget _drawColumn(String title, String text, Function onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 8.0,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16.0,
          ),
          child: GestureDetector(
            onTap: onTap,
            child: Row(
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
