import 'package:flutter/material.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  String _selectedMood = 'Happy';
  final TextEditingController _entryController = TextEditingController();

  final Map<String, Color> moodColors = {
    'Happy': Color(0xFFFFF9C4),
    'Excited': Color(0xFFFFE0B2),
    'Sad': Color(0xFFB3E5FC),
    'Calm': Color(0xFFDCEDC8),
    'Confused': Color(0xFFD1C4E9),
    'Anxious': Color(0xFFFFCDD2),
    'Loved': Color(0xFFFFF1F1),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: moodColors[_selectedMood],
      appBar: AppBar(
        backgroundColor: Colors.teal.shade200,
        title: const Text('New Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mood:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            DropdownButton<String>(
              value: _selectedMood,
              icon: const Icon(Icons.arrow_drop_down),
              isExpanded: true,
              items: moodColors.keys.map((mood) {
                return DropdownMenuItem<String>(
                  value: mood,
                  child: Text(mood),
                );
              }).toList(),
              onChanged: (String? newMood) {
                setState(() {
                  _selectedMood = newMood!;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Your Entry:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: TextField(
                controller: _entryController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: 'Write your thoughts here...',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context, {
                    'mood': _selectedMood,
                    'entry': _entryController.text.trim(),
                  });
                },
                icon: const Icon(Icons.save),
                label: const Text('Save Entry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade300,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

