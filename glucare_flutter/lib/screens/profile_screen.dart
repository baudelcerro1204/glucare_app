import 'package:flutter/material.dart';
import 'package:glucare/model/UserDTO.dart';
import 'package:glucare/services/api_service.dart';
import 'package:glucare/screens/login_screen.dart'; 

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  ApiService _apiService = ApiService('http://192.168.0.5:8080');


  UserDTO? _user;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  bool _isEditing = false;

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
      final updatedUser = UserDTO(
        nombre: _nameController.text,
        correoElectronico: _emailController.text,
        edad: int.parse(_ageController.text),
      );
      await _apiService.updateUserProfile(updatedUser);
      setState(() {
        _user = updatedUser;
        _isEditing = false;
      });
    } catch (e) {
      print('Error al guardar perfil de usuario: $e');
    }
  }

  Future<void> _logout() async {
    try {
      await _apiService.logout();
      await _apiService.deleteToken();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => IniciarSesion(correoElectronico: '')),
      );
    } catch (e) {
      print('Error al cerrar sesión: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC0DEF4),
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _user != null
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    enabled: _isEditing,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Correo Electrónico',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    enabled: _isEditing,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      labelText: 'Edad',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    enabled: _isEditing,
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_isEditing) {
              _saveProfile();
            } else {
              setState(() {
                _isEditing = true;
              });
            }
          },
          child: Icon(_isEditing ? Icons.check : Icons.edit),
          backgroundColor: Color(0xFF2A629A)),
    );
  }
}
