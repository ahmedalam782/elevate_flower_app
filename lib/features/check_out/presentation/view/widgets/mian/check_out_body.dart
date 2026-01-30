import 'package:elevate_flower_app/features/check_out/presentation/view/widgets/delivery_address_section/delivery_addresses_section.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view/widgets/mian/delivery_time_section.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view/widgets/gift_section/gift_section.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view/widgets/mian/price_section.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view/widgets/payment_type_section/payment_type_section.dart';
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
