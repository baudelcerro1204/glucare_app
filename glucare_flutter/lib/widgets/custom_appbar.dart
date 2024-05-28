import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Center(
        child: Image.asset(
          'lib/assets/logo.png',
          height: 2000, // Ajusta el tamaño según sea necesario
        ),
      ),
      backgroundColor: Color(0xFFE3F2FD),
      iconTheme: IconThemeData(color: Colors.black),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
