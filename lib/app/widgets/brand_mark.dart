import 'package:flutter/material.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({
    super.key,
    this.size = 56,
    this.iconSize = 28,
  });

  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF294EF2), Color(0xFF3A67FF), Color(0xFF09B6D9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size * 0.32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33294EF2),
            blurRadius: 22,
            offset: Offset(0, 12),
          ),
        ],
        border: Border.all(
          color: const Color(0x66FFFFFF),
          width: 1.2,
        ),
      ),
      child: Icon(Icons.account_balance_wallet_rounded,
          color: Colors.white, size: iconSize),
    );
  }
}
