// lib/widgets/custom_app_bar.dart

import 'package:flutter/material.dart';

import '../../utils/strings.dart';

class TableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TableAppBar({
    Key? key,
    this.title = AppStrings.appTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      elevation: 5.0,
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.blue.shade800,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
