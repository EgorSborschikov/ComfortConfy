import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConferenceStartTimeChoice extends StatefulWidget{
  const ConferenceStartTimeChoice({super.key});

  @override
  State<ConferenceStartTimeChoice> createState() => _ConferenceStartTimeChoiceState();
}

class _ConferenceStartTimeChoiceState extends State<ConferenceStartTimeChoice> {
  TimeOfDay? _startTime;

  @override
  void initState() {
    super.initState();
    _loadStartTime();
  }

  Future<void> _loadStartTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? startHour = prefs.getInt('opening_hour');
    int? startMinute = prefs.getInt('opening_minute');

    setState(() {
      _startTime = startHour != null && startMinute != null
          ? TimeOfDay(hour: startHour, minute: startMinute)
          : null;
    });
  }

  Future<void> _saveStartTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_startTime != null) {
      await prefs.setInt('opening_hour', _startTime!.hour);
      await prefs.setInt('opening_minute', _startTime!.minute);
    }
  }

  void _selectStartTime(BuildContext context) {
    _showTimePicker(context, true);
  }

  Future<void> _showTimePicker(BuildContext context, bool isStart) async {
    final DateTime now = DateTime.now();
    final TimeOfDay initialTime = _startTime ?? TimeOfDay.now();

    final TimeOfDay? picked = await showCupertinoModalPopup<TimeOfDay>(
      context: context,
      builder: (context) {
        return Container(
          height: 250,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime(now.year, now.month, now.day, initialTime.hour, initialTime.minute),
            onDateTimeChanged: (DateTime newTime) {
              setState(() {
                if (isStart) {
                  _startTime = TimeOfDay.fromDateTime(newTime);
                }
                _saveStartTime();
              });
            },
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
              onPressed: () => _selectStartTime(context),
              /*child: Text(
                AppLocalizations.of(context)!.selectTimeStart,
                style: Theme.of(context).textTheme.titleMedium,
              ),*/
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.selectTimeStart,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(width: 8.0),
                  Icon(CupertinoIcons.clock_solid, 
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ],
              ),
            ),
            Text(_startTime != null ? _startTime!.format(context) : AppLocalizations.of(context)!.timeStart),  
          ],
        ),
      ]
    );
  }
}