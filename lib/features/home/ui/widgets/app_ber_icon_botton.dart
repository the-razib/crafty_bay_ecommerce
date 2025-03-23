import 'package:flutter/material.dart';

class AppBerIconButton extends StatelessWidget {
  const AppBerIconButton({
    super.key,
    required this.icon,
    required this.onTab,
  });

  final IconData icon;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade100,
        radius: 16,
        child: Icon(
          icon,
          size: 20,
          color: Colors.black45,
        ),
      ),
    );
  }
}
