import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/strings.dart';
import 'community_detail_screen.dart';

class CommunityCreationScreen extends StatefulWidget {
  @override
  _CommunityCreationScreenState createState() =>
      _CommunityCreationScreenState();
}

class _CommunityCreationScreenState extends State<CommunityCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name, _description;
  String _type = 'Public';
  final List<String> _types = [
    'Public',
    'Private',
    'Event-based',
    'Invitation-based',
    'Paid'
  ];

  Future<void> _saveCommunity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? communities = prefs.getStringList('communities') ?? [];

    String community = 'Name: $_name, Description: $_description, Type: $_type';
    communities.add(community);

    await prefs.setStringList('communities', communities);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Community Created!')),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommunityDetailScreen(
          name: _name,
          description: _description,
          type: _type,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.createCommunity)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration:
                    const InputDecoration(labelText: Strings.communityName),
                validator: (value) {
                  if (value!.isEmpty) {
                    return Strings.enterName;
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
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
                onSaved: (value) => _description = value!,
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: Strings.type),
                value: _type,
                items: _types.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _type = value!;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                child: const Text(Strings.create),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    _saveCommunity();
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
