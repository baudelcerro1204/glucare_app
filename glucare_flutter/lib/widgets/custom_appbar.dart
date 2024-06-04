import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Center(
        child: Image.asset(
          'lib/assets/glucare_removeBG.png',
          height: 2000, // Ajusta el tamaño según sea necesario
        ),
      ),
      backgroundColor: const Color(0xFFC0DEF4),
      iconTheme: const IconThemeData(color: Colors.black),
      automaticallyImplyLeading: false, // Esto remueve la flecha de retroceso
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
