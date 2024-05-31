import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/color.dart';
import '../constants/strings.dart';
import 'community_creation_screen.dart';

class InterestSelectionScreen extends StatefulWidget {
  final String email;

  InterestSelectionScreen({required this.email});

  @override
  _InterestSelectionScreenState createState() =>
      _InterestSelectionScreenState();
}

class _InterestSelectionScreenState extends State<InterestSelectionScreen> {
  final List<String> _interests = ['Sports', 'Music', 'Tech', 'Art'];
  final List<String> _selectedInterests = [];

  _saveInterests() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('interests', _selectedInterests);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CommunityCreationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.selectInterestText),
        backgroundColor: AppColor.appbar,
      ),
      body: ListView.builder(
        itemCount: _interests.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(_interests[index]),
            value: _selectedInterests.contains(_interests[index]),
            onChanged: (bool? selected) {
              setState(() {
                if (selected != null && selected) {
                  _selectedInterests.add(_interests[index]);
                } else {
                  _selectedInterests.remove(_interests[index]);
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveInterests,
        child: const Icon(Icons.save),
      ),
    );
  }
}
