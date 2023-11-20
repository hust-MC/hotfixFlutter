import 'dart:async';

import 'package:build/build.dart';

// 1、读取输入文件
// 2、在每个Dart文件头加上一段文字
// 3、输出新的代码

class TestBuilder implements Builder {
  @override
  Future<FutureOr<void>> build(BuildStep buildStep) async {
    var inputId = buildStep.inputId;
    var contents = await buildStep.readAsString(inputId);
    var newFile = inputId.addExtension('.copyright');

    await buildStep.writeAsString(newFile, 'CopyRight\n${contents}');
  }

  @override
  Map<String, List<String>> get buildExtensions => {'.dart': ['.dart.copyright']};

}