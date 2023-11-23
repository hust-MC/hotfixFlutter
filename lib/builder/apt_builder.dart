import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../GenerateInfo.dart';

class AptBuilder extends GeneratorForAnnotation<GenerateInfo>{
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    return "String a = '123';";
  }
}

Builder testApt(BuilderOptions options) => LibraryBuilder(AptBuilder());