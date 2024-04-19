import 'package:flutter/material.dart';

class RoundCloseButton extends StatelessWidget {
  const RoundCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.close_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
