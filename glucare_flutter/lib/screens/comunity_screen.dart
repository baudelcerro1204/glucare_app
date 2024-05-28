import 'package:flutter/material.dart';
import 'package:glucare/screens/create_post_screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<Map<String, String>> _posts = [
    {
      'username': 'Dan Williams',
      'userProfilePic': 'https://via.placeholder.com/150',
      'description': 'Recuerdo claramente la primera vez que tuve una hipoglucemia severa. Fue aterrador. Me sentí mareado, débil y completamente desorientado. Mis manos temblaban y no podía pensar con claridad. Por suerte, tenía mi kit de emergencia a mano y pude recuperarme. Fue un recordatorio impactante de lo importante que es llevar un control constante de mi glucosa y estar preparado para cualquier situación.',
      'date': '10/5/2024'
    },
    {
      'username': 'Karen Han',
      'userProfilePic': 'https://via.placeholder.com/150',
      'description': 'Desde que fui diagnosticado con diabetes, mi vida ha dado un giro inesperado. De repente, me encontré enfrentando un mundo de decisiones complicadas y ajustes en mi estilo de vida. Pasé por momentos de incertidumbre y preocupación, pero también descubrí una fuerza interior que ni siquiera sabía que tenía.',
      'date': '11/5/2025'
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
        backgroundColor: Color(0xFFE3F2FD), // Cambia el color de la AppBar si es necesario
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
      body: Container(
        color: Color(0xFFE3F2FD), // Fondo azul claro
        child: ListView(
          children: _posts.map((post) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(post['userProfilePic']!),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post['username']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              post['date']!,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      post['description']!,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
