import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'entry_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, Map<String, String>> _journalEntries = {}; // date → mood + entry

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFBF0),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFAF3E0),
            border: Border(
              bottom: BorderSide(
                color: Colors.brown.shade200,
                width: 2,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Text(
              '📒 Daily Journal',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Colors.brown.shade700,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });

              if (_journalEntries.containsKey(selectedDay)) {
                final mood = _journalEntries[selectedDay]!['mood'];
                final text = _journalEntries[selectedDay]!['entry'];
                _showEntryDialog(context, mood!, text!);
              }
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, _) {
                if (_journalEntries.containsKey(date)) {
                  final mood = _journalEntries[date]!['mood'];
                  final color = _moodColor(mood!);
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: Text('${date.day}'),
                  );
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Tap a date to view entry.\nTap + to add a new one.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => EntryScreen()),
          );

          if (result != null && _selectedDay != null) {
            setState(() {
              _journalEntries[_selectedDay!] = {
                'mood': result['mood'],
                'entry': result['entry'],
              };
            });
          }
        },
        backgroundColor: Colors.teal.shade200,
        child: Icon(Icons.add),
      ),
    );
  }

  Color _moodColor(String mood) {
    final moodColors = {
      'Happy': Color(0xFFFFF9C4),
      'Excited': Color(0xFFFFE0B2),
      'Sad': Color(0xFFB3E5FC),
      'Calm': Color(0xFFDCEDC8),
      'Confused': Color(0xFFD1C4E9),
      'Anxious': Color(0xFFFFCDD2),
      'Loved': Color(0xFFFFF1F1),
    };
    return moodColors[mood] ?? Colors.grey.shade300;
  }

  void _showEntryDialog(BuildContext context, String mood, String entry) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Entry - $mood'),
        content: Text(entry),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
