import 'package:flutter/material.dart';
import 'package:glucare/model/UserDTO.dart';
import 'package:glucare/services/api_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ApiService _apiService = ApiService('http://192.168.0.15:8080');

  UserDTO? _user;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final userProfile = await _apiService.getUserProfile();
      setState(() {
        _user = userProfile;
        _nameController.text = _user!.nombre;
        _emailController.text = _user!.correoElectronico;
        _ageController.text = _user!.edad.toString();
      });
    } catch (e) {
      print('Error al obtener perfil de usuario: $e');
    }
  }

  Future<void> _saveProfile() async {
    try {
      // Actualizar los datos del usuario en el backend utilizando _apiService
      final updatedUser = UserDTO(
        nombre: _nameController.text,
        correoElectronico: _emailController.text,
        edad: int.parse(_ageController.text),
      );
      await _apiService.updateUserProfile(updatedUser);
      // Actualizar el estado local con los nuevos datos del usuario
      setState(() {
        _user = updatedUser;
      });
    } catch (e) {
      print('Error al guardar perfil de usuario: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: _user != null
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Nombre'),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Correo Electrónico'),
                  ),
                  TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(labelText: 'Edad'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _saveProfile,
                    child: Text('Guardar'),
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
