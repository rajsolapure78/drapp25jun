import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerTimeline extends StatefulWidget {
  final DateRangePickerController controller;

  const DatePickerTimeline(
      {Key? key, required this.controller, required this.onSelected})
      : super(key: key);

  final Function(DateTime dateTime) onSelected;

  @override
  _DatePickerTimelineState createState() => _DatePickerTimelineState();
}

class _DatePickerTimelineState extends State<DatePickerTimeline> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0,8,0,8),
                child: SizedBox(
                  height: 80,
                  child: SfDateRangePicker(
                    backgroundColor: Colors.white,
                    controller: widget.controller,
                    selectionColor: Colors.blue,
                    initialSelectedDate: DateTime.now(),
                    view: DateRangePickerView.month,
                    headerHeight: 0,
                    cellBuilder: cellBuilder,
                    onSelectionChanged: (onSelectionChanged) {
                      widget.onSelected(onSelectionChanged.value);
                    },
                    monthViewSettings: const DateRangePickerMonthViewSettings(
                        viewHeaderHeight: 0, numberOfWeeksInView: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget cellBuilder(BuildContext context, DateRangePickerCellDetails details) {
    final bool isSelected = widget.controller.selectedDate != null &&
        details.date.year == widget.controller.selectedDate.year &&
        details.date.month == widget.controller.selectedDate.month &&
        details.date.day == widget.controller.selectedDate.day;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          DateFormat('MMM').format((details.date)),
          textAlign: TextAlign.center,
          style: isSelected
              ? const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)
              : const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
        ),
        Text(
          details.date.day.toString(),
          textAlign: TextAlign.center,
          style: isSelected
              ? const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)
              : const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
        ),
        Text(
          DateFormat('EEE').format((details.date)),
          textAlign: TextAlign.center,
          style: isSelected
              ? const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)
              : const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
