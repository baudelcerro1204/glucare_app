import 'package:flutter/material.dart';

class CommunityPost extends StatelessWidget {
  final String username;
  final String userProfilePic;
  final String postImage;
  final String description;

  const CommunityPost({
    super.key,
    required this.username,
    required this.userProfilePic,
    required this.postImage,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(userProfilePic),
            ),
            title: Text(username),
          ),
          Image.network(postImage),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(description),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.comment),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
