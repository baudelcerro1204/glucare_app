import 'package:flutter/material.dart';
import 'package:glucare/screens/set_new_password_screen.dart';
import 'package:glucare/services/api_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final ApiService apiService = ApiService('http://192.168.0.136:8080');

  void _requestPasswordChange() async {
    final String email = _emailController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingrese su correo electrónico')),
      );
      return;
    }

    try {
      // Aquí llamas al servicio para solicitar el cambio de contraseña
      // await apiService.requestPasswordChange(email);

      // Simula un retraso para mostrar la funcionalidad (elimina esta línea en producción)
      await Future.delayed(const Duration(seconds: 2));

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SetNewPasswordScreen(email: email)),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Se ha enviado una notificación a su correo electrónico')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al solicitar cambio de contraseña: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC0DEF4),
      appBar: AppBar(
        title: const Text('Cambiar Contraseña'),
        backgroundColor: Color(0xFFC0DEF4),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  'lib/assets/glucare_removeBG.png',
                  height: 200, // Ajusta el tamaño según sea necesario
                ),
                const SizedBox(height: 30),
                const Text(
                  'Recibirá una notificación en su casilla de email para recuperar su cuenta',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _requestPasswordChange,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                    child: const Text('Solicitar nueva contraseña'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
