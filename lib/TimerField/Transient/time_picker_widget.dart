import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/tabbar_screen/Tenant_schedule_tab.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'button_widget.dart';

class TimePickerWidget2 extends StatefulWidget {
  @override
  _TimePickerWidget2State createState() => _TimePickerWidget2State();
}

class _TimePickerWidget2State extends State<TimePickerWidget2> {
  TimeOfDay time;

  String getText() {
    if (time == null) {
      return 'Select Time';
    } else {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    }
  }

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget2(
        title: 'Time',
        text: getText(),
        onClicked: () => pickTime(context),
      );

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if (newTime == null) return;

    setState(() => time = newTime);
    // final f = new ;
    print(newTime);
    String ftime = "${newTime.hour}:${newTime.minute}";
    Provider.of<TenantScheduleProvider>(context, listen: false)
        .onchange("Atime", ftime);
  }
}
