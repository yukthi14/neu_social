import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/color.dart';
import '../constants/strings.dart';
import 'event_creation_screen.dart';

class CommunityDetailScreen extends StatefulWidget {
  final String name;
  final String description;
  final String type;

  CommunityDetailScreen({
    required this.name,
    required this.description,
    required this.type,
  });

  @override
  _CommunityDetailScreenState createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {
  List<String> _events = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  _loadEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? events = prefs.getStringList(widget.name) ?? [];
    setState(() {
      _events = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.communityDetails),
        backgroundColor: AppColor.appbar,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Name: ${widget.name}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Description: ${widget.description}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Type: ${widget.type}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Create Event'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventCreationScreen(
                      communityName: widget.name,
                    ),
                  ),
                ).then((_) {
                  _loadEvents(); // Refresh the list of events after returning from event creation
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Events:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _events.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_events[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
