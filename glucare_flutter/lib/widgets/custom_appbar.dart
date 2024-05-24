import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true, // Asegúrate de que el título esté centrado
      title: Image.asset(
        'lib/assets/logo.png',
        height: 700, // Ajusta el tamaño según sea necesario
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
