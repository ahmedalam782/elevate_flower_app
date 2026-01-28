import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/features/user_adresses/presentation/view/widgets/address_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAdressesBody extends StatelessWidget {
  const UserAdressesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return AddressCell(
                    onEdit: () {
                      // TODO GO TO EDIT ADDRESS SCREEN
                      print("EDIT ADDRESS $index");
                    },
                    onDelete: () {
                      // TODO DELETE ADDRESS
                      print("DELETE ADDRESS $index");
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 24.h),
            CustomButton(
              onPressed: () {
                // TODO GO TO ADD NEW ADDRESS SCREEN
              },
              title: LocaleKeys.address_add_new_address.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
