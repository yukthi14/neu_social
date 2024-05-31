import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/color.dart';
import '../constants/strings.dart';

class CommunityFeedScreen extends StatefulWidget {
  @override
  _CommunityFeedScreenState createState() => _CommunityFeedScreenState();
}

class _CommunityFeedScreenState extends State<CommunityFeedScreen> {
  List<Map<String, String>> _communities = [
    {
      'name': 'Flutter Devs',
      'description': 'All about Flutter',
      'type': 'Public'
    },
    {
      'name': 'Music Lovers',
      'description': 'Discuss and share music',
      'type': 'Private'
    },
    // Add more communities
  ];
  List<String> _interests = [];

  _loadInterests() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _interests = prefs.getStringList('interests') ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    _loadInterests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.communityFeed),
        backgroundColor: AppColor.appbar,
      ),
      body: ListView.builder(
        itemCount: _communities.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_communities[index]['name']!),
              subtitle: Text(_communities[index]['description']!),
              trailing: Text(_communities[index]['type']!),
              onTap: () {
                // Navigate to community detail screen
              },
            ),
          );
        },
      ),
    );
  }
}
