import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neu_social/constants/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/strings.dart';

class EventCreationScreen extends StatefulWidget {
  final String communityName;

  EventCreationScreen({required this.communityName});

  @override
  _EventCreationScreenState createState() => _EventCreationScreenState();
}

class _EventCreationScreenState extends State<EventCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _eventName, _eventDescription;
  DateTime _eventDate = DateTime.now();

  Future<void> _saveEvent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? events = prefs.getStringList(widget.communityName) ?? [];

    String event =
        'Event: $_eventName, Description: $_eventDescription, Date: ${_eventDate.toString()}';
    events.add(event);

    await prefs.setStringList(widget.communityName, events);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Event Created!')),
    );

    Navigator.pop(context);
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _eventDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _eventDate) {
      setState(() {
        _eventDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.createEvent),
        backgroundColor: AppColor.appbar,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: Strings.eventName),
                validator: (value) {
                  if (value!.isEmpty) {
                    return Strings.enterEventName;
                  }
                  return null;
                },
                onSaved: (value) => _eventName = value!,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: Strings.description),
                validator: (value) {
                  if (value!.isEmpty) {
                    return Strings.enterDescription;
                  }
                  return null;
                },
                onSaved: (value) => _eventDescription = value!,
              ),
              const SizedBox(height: 20),
              Text(
                "Event Date: ${DateFormat('yyyy-MM-dd').format(_eventDate)}",
                style: const TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text(Strings.selectDate),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text(Strings.create),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    _saveEvent();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
