import 'package:flutter/material.dart';
import 'package:glucare/main.dart';
import 'package:glucare/screens/register_screen.dart';
import 'package:glucare/services/api_service.dart';

class IniciarSesion extends StatelessWidget {
  final TextEditingController _correoElectronicoController;
  final TextEditingController _passwordController = TextEditingController();
  final ApiService apiService = ApiService('http://192.168.0.5:8080');

  IniciarSesion({Key? key, required String correoElectronico}) 
      : _correoElectronicoController = TextEditingController(text: correoElectronico),
        super(key: key);

  // Método para manejar el inicio de sesión
  void _login(BuildContext context) async {
    final String correoElectronico = _correoElectronicoController.text;
    final String password = _passwordController.text;

    if (correoElectronico.isEmpty || password.isEmpty) {
      // Mostrar mensaje de error si los campos están vacíos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete todos los campos')),
      );
      return;
    }

    try {
      final response = await apiService.login(correoElectronico, password);
      if (response.statusCode == 200) {
        // Mostrar mensaje de éxito y navegar a la pantalla principal
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inicio de sesión exitoso')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        // Mostrar mensaje de error en el inicio de sesión
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email o contraseña incorrectos')),
        );
      }
    } catch (e) {
      print(e);
      // Mostrar mensaje de error en el inicio de sesión
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email o contraseña incorrectos')),
      );
    }
  }

  // Método para manejar el olvido de contraseña
  void _forgotPassword(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Funcionalidad de recuperar contraseña')),
    );
  }

  // Método para navegar a la pantalla de registro
  void _goToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CrearCuenta()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.tag_faces,
                  size: 50,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _correoElectronicoController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contraseña',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _login(context);
                },
                child: const Text('Iniciar Sesión'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      _forgotPassword(context);
                    },
                    child: const Text('Olvidé mi contraseña'),
                  ),
                  TextButton(
                    onPressed: () {
                      _goToRegister(context); // Ir a la pantalla de registro
                    },
                    child: const Text('Registrarse'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
