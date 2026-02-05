import 'dart:io';

import 'package:easy_localization/easy_localization.dart';

import '../helper/phone_helper/phone_length_helper.dart';

class Validations {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'validations.password_required'.tr();
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'validations.set_password_1_condition_error'.tr();
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'validations.set_password_2_condition_error'.tr();
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'validations.set_password_3_condition_error'.tr();
    }

    if (!value.contains(
      RegExp(r'[!@#\$%\^&\*\(\)_\-\+=\[\]\{\};:\,<>\./\\|~`]'),
    )) {
      return 'validations.set_password_4_condition_error'.tr();
    }

    if (value.length < 8 || value.length > 30) {
      return 'validations.set_password_5_condition_error'.tr();
    }

    return null;
  }

  static String? validatePasswordVerification(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'validations.confirm_password_required'.tr();
    } else if (value != password) {
      return 'validations.confirm_password_mismatch'.tr();
    }
    return null;
  }

  static String? validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'validations.password_required'.tr();
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "validations.email_required".tr();
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return "validations.email_invalid".tr();
    }

    return null;
  }

  static String? validatePhoneNumber(
    String? value,
    int phoneLength,
    String countryCode,
  ) {
    if (value == null || value.isEmpty) {
      return 'validations.phone_required'.tr();
    } else if (PhoneHelper.isValidPhoneForCountry(value, countryCode)) {
      return 'validations.phone_invalid_start'.tr();
    } else if (value.length < phoneLength) {
      return 'validations.phone_length_error'.tr(
        args: [phoneLength.toString()],
      );
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "validations.name_required".tr();
    } else {
      return null;
    }
  }

  static String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return "validations.first_name_required".tr();
    } else {
      return null;
    }
  }

  static String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return "validations.last_name_required".tr();
    } else {
      return null;
    }
  }

  static String? validatePin(String? value, int length) {
    if (value == null || value.isEmpty) {
      return 'validations.pin_required'.tr();
    }
    if (value.length != length) {
      return 'validations.pin_length_error'.tr(args: [length.toString()]);
    } else {
      return null;
    }
  }

  static String? validateUserImage(File? value) {
    if (value == null) {
      return "validations.profile_image".tr();
    } else {
      return null;
    }
  }

  static String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'validations.username_required'.tr();
    }

    return null;
  }
}
