import 'package:flutter/material.dart';

class GallaryImageItem extends StatelessWidget {
  final String image;

  const GallaryImageItem({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: .2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.network(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
