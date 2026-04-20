import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'card_back.dart';
import 'card_front.dart';

class CardPreview extends StatelessWidget {
  const CardPreview({
    super.key,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiry,
    required this.cvv,
    required this.isFlipped,
  });

  final String cardNumber;
  final String cardHolder;
  final String expiry;
  final String cvv;
  final bool isFlipped;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: isFlipped
            ? CardBack(cvv: cvv, key: const ValueKey('back'))
            : CardFront(
                cardNumber: cardNumber,
                cardHolder: cardHolder,
                expiry: expiry,
                key: const ValueKey('front'),
              ),
      ),
    );
  }
}
