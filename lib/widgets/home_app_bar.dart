import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Image(
              image: AssetImage('assets/images/logo.png'),
              height: 30,
            ),
            IconButton(
              icon: const Icon(Icons.filter_alt),
              color: Colors.white,
              onPressed: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
