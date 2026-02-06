import '../delivery_address_section/delivery_addresses_section.dart';
import 'delivery_time_section.dart';
import '../gift_section/gift_section.dart';
import 'price_section.dart';
import '../payment_type_section/payment_type_section.dart';
import 'package:flutter/material.dart';

class CheckOutBody extends StatelessWidget {
  const CheckOutBody({super.key, required this.totalPrice});
  final double totalPrice;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const RangeMaintainingScrollPhysics(),
      child: Column(
        spacing: 24,
        children: [
          const DelieveryTimeSection(),
          const DeliveryAddressesSection(),
          const PaymentTypeSection(),
          const GiftSection(),
          PriceSection(totalPrice: totalPrice),
        ],
      ),
    );
  }
}
