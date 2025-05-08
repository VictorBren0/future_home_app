import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './scale_card.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final double value;
  final int scaleId;
  final String subtitle;
  final DateTime date;
  final VoidCallback? onTap;
  final bool isHome;

  const ItemCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.scaleId,
    required this.date,
    required this.isHome,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onTap: onTap,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
          overflow: TextOverflow.ellipsis,
            ),
            Text(
              NumberFormat.simpleCurrency(locale: 'pt_BR').format(value),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        trailing: ScaleCard(scaleId),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isHome
                ? Icon(
                    Icons.home_outlined,
                    color: Colors.deepOrange,
                    size: 24,
                  )
                : Icon(
                    Icons.apartment_outlined,
                    color: Colors.deepOrange,
                    size: 24,
                  ),
            Text(
              DateFormat('dd/MM/yyyy').format(date),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
