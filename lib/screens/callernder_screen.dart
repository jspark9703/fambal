import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _eventController = TextEditingController();

  final Map<DateTime, List<String>> _events = {};

  void _addEvent() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("일정을 추가해추세요"),
          content: TextFormField(
            controller: _eventController,
            decoration: const InputDecoration(
              labelText: '일정',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 닫기 버튼
              },
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                _saveEvent();
                Navigator.pop(context); // 저장 버튼
              },
              child: const Text('저장'),
            ),
          ],
        );
      },
    );
  }

  void _editEvent(String event) {
    _eventController.text = event;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("일정을 입력해주세요"),
          content: TextFormField(
            controller: _eventController,
            decoration: const InputDecoration(
              labelText: '일정',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 닫기 버튼
              },
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                _saveEvent();
                Navigator.pop(context); // 저장 버튼
              },
              child: const Text('저장'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteEvent(event);
                Navigator.pop(context); // 삭제 버튼
              },
              child: const Text('삭제'),
            ),
          ],
        );
      },
    );
  }

  void _saveEvent() {
    setState(() {
      _events[_selectedDate] ??= [];
      _events[_selectedDate]?.add(_eventController.text);
      _eventController.clear();
    });
  }

  void _deleteEvent(String event) {
    setState(() {
      _events[_selectedDate]?.remove(event);
    });
  }

  Widget _showEventsList() {
    if (_events[_selectedDate] != null) {
      return Column(
        children: _events[_selectedDate]!
            .map((event) => ListTile(
                  title: Text(event),
                  onTap: () {
                    _editEvent(event);
                  },
                ))
            .toList(),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 243, 221, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(252, 243, 221, 1),
        actions: const <Widget>[],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                TableCalendar(
                  firstDay: DateTime.utc(2023, 12, 25),
                  lastDay: DateTime.utc(2030, 12, 25),
                  focusedDay: DateTime.now(),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDate, day);
                  },
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    titleTextFormatter: (date, locale) =>
                        DateFormat.yMMMMd(locale).format(date),
                    formatButtonVisible: false,
                    titleTextStyle: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                    headerPadding: const EdgeInsets.symmetric(vertical: 4.0),
                    leftChevronIcon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 20.0,
                      color: Color(0xFF8A9FA7),
                    ),
                    rightChevronIcon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 20.0,
                      color: Color(0xFF8A9FA7),
                    ),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDate = selectedDay;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                Text(
                  DateFormat.yMd().format(_selectedDate),
                  style: const TextStyle(fontSize: 16.0),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addEvent();
                  },
                  child: const Text(
                    '일정 추가',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                _showEventsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
