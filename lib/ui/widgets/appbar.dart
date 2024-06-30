import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool leading;

  const CustomAppBar({super.key, this.title, required this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: true,
      leading: leading
          ? InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFFFFFFFF),
              ),
            )
          : null,
      backgroundColor: const Color(0xFF17192D),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
