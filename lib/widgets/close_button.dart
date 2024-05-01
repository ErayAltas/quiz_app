import 'package:flutter/material.dart';

class RoundCloseButton extends StatelessWidget {
  const RoundCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.close_rounded, size: 30),
      ),
    );
  }
}
