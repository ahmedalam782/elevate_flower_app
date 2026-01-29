import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AssetJasonparser {
  const AssetJasonparser();

  /// Generic parser for phpMyAdmin JSON exports
  Future<dynamic> parseTableData({required String assetPath}) async {
    try {
      final jsonString = await rootBundle.loadString(assetPath);
      final decoded = json.decode(jsonString);

      return decoded;
      // return dataList.map((e) => fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {}
  }
}
