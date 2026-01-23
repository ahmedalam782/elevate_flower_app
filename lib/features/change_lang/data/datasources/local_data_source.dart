
import 'package:flutter/material.dart';

import '../../../../core/config/base_response/result.dart';

abstract class ChangeLangLocalDataSource {
  Future<Result<String>> getLanguage();
  Future<Result<void>> setLanguage(Locale language, BuildContext context);
}
