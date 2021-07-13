

import 'package:get/get.dart';
import 'package:todo/locale/en_US.dart';
import 'package:todo/locale/zh_CN.dart';

class TodoTranslation extends Translations {

  @override
  Map<String, Map<String, String>> get keys {
    return {
      "en_GB" : enUS,
      "zh" : zhCN
    };
  }
}
