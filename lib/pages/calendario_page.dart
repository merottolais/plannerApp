import 'package:flutter/material.dart';
import 'package:planner_app/controller/task_controller.dart';
import 'package:planner_app/models/task_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarioPage extends StatelessWidget {
  CalendarioPage({Key? key}) : super(key: key);

  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    tasks = carregarTodasTasks()!;
    return SfCalendar(
      view: CalendarView.month,
      dataSource: MeetingDataSource(_getDataSource()),
      // by default the month appointment display mode set as Indicator, we can
      // change the display mode as appointment using the appointment display
      // mode property
      monthViewSettings: const MonthViewSettings(
        showAgenda: true,
        agendaItemHeight: 50,
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];

    final DateTime today = DateTime.now();

    for (var task in tasks) {
      final DateTime inicioEvento = DateTime(
        task.data.year,
        task.data.month,
        task.data.day,
        task.hora,
        task.minutos,
      );

      final DateTime finalEvento = inicioEvento.add(
        const Duration(
          hours: 1,
        ),
      );

      meetings.add(
        Meeting(
          task.titulo,
          inicioEvento,
          finalEvento,
          const Color(0xFF0F8644),
          false,
        ),
      );
    }

    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}