import 'package:flutter/material.dart';
import 'package:glucare/model/CommunityPost.dart';
import 'package:glucare/services/api_service.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService('http://192.168.0.15:8080'); // Asegúrate de cambiar la URL a la de tu API
  }

  Future<void> _publishPost() async {
    String description = _descriptionController.text;
    if (description.isEmpty) {
      // Mostrar un mensaje de error si la descripción está vacía
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('La descripción no puede estar vacía')),
      );
      return;
    }

    try {
      CommunityPost newPost = CommunityPost(
        id: null,
        content: description,
        date: DateTime.now(),
        userName: '', // Este valor será asignado por el backend
      );
      await apiService.createPost(newPost);
      Navigator.pop(context, true); // Regresa a la pantalla anterior e indica que se publicó un post
    } catch (e) {
      // Manejar errores
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al publicar el post: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Publicación'),
        backgroundColor: Color(0xFFE3F2FD), // Cambia el color de la AppBar si es necesario
      ),
      body: Container(
        color: Color(0xFFE3F2FD), // Fondo azul claro
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Aquí eliminamos la fila que contenía la imagen y el nombre del usuario.
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _descriptionController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: 'Escriba aquí ...',
                          border: InputBorder.none,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Lógica para editar el texto
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: _publishPost,
                  child: const Text('Publicar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
