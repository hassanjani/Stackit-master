import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/tabbar_screen/Tenant_schedule_tab.dart';
import 'button_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DatePickerWidget extends StatefulWidget {
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime date;

  String getText() {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('MM-dd-yyyy').format(date);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
        title: 'Date',
        text: getText(),
        onClicked: () => pickDate(context),
      );

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;

    setState(() => date = newDate);
    print(newDate.toString());
    final f = new DateFormat('MM-dd-yyyy');
    // String fdate="${newDate.year}-${newDate.month}-${newDate.day}";
    String fdate = f.format(newDate).toString();

    Provider.of<TenantScheduleProvider>(context, listen: false)
        .onchange("Adate", fdate);
  }
}
