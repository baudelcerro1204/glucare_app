import 'package:flutter/material.dart';
import 'package:glucare/widgets/comunity_post.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        CommunityPost(
          username: 'User1',
          userProfilePic: 'https://via.placeholder.com/150',
          postImage: 'https://via.placeholder.com/600',
          description: 'This is a description of the first post.',
        ),
        CommunityPost(
          username: 'User2',
          userProfilePic: 'https://via.placeholder.com/150',
          postImage: 'https://via.placeholder.com/600',
          description: 'This is a description of the second post.',
        ),
        // Añade más publicaciones según sea necesario
      ],
    );
  }
}
