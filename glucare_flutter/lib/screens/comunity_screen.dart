import 'package:flutter/material.dart';
import 'package:glucare/widgets/comunity_post.dart';
import 'package:glucare/screens/create_post_screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<Map<String, String>> _posts = [
    {
      'username': 'User1',
      'userProfilePic': 'https://via.placeholder.com/150',
      'postImage': 'https://via.placeholder.com/600',
      'description': 'This is a description of the first post.',
    },
    {
      'username': 'User2',
      'userProfilePic': 'https://via.placeholder.com/150',
      'postImage': 'https://via.placeholder.com/600',
      'description': 'This is a description of the second post.',
    },
  ];

  void _addPost(String description) {
    setState(() {
      _posts.add({
        'username': 'NewUser',
        'userProfilePic': 'https://via.placeholder.com/150',
        'postImage': 'https://via.placeholder.com/600',
        'description': description,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comunidad'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreatePostScreen()),
              );

              if (result != null) {
                _addPost(result);
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: _posts.map((post) {
          return CommunityPost(
            username: post['username']!,
            userProfilePic: post['userProfilePic']!,
            postImage: post['postImage']!,
            description: post['description']!,
          );
        }).toList(),
      ),
    );
  }
}

