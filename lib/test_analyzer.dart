import 'dart:convert';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

main() {
  String content = 'int a = 10 + 20;';

  // 接收一个代码段（可以是 String类型，也可以是 File）
  ParseStringResult result = parseString(content: content);
  // 将解析结果转化成一个编译单元
  CompilationUnit unit = result.unit;

  // 通过 Accept 开启遍历
  var astResult = unit.accept(SimpleVisitor());
  // 拿到遍历结果，转化成 json
  print(JsonEncoder.withIndent('  ').convert(astResult));
}

// 1、simple 里面的 visitor 函数，返回 Map 类型，可以帮助我们访问所有的结果
// 2、每次需要主动调用下一个结点的 accept 方法，否则便利中断
// 3、如果结点类型属于 NodeList，需要把 List 遍历完再调用 accept 方法
// 4、有些结点下可能有多个子结点需要调用，子结点都需要调用 accept
class SimpleVisitor extends SimpleAstVisitor<Map> {
  @override
  Map visitCompilationUnit(CompilationUnit node) {
    return {'unit': accept(node.declarations, this)};
  }

  @override
  Map visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    return {'topLevel': node.variables.accept(this)};
  }

  @override
  Map visitVariableDeclaration(VariableDeclaration node) {
    return {'name': node.name.accept(this), 'initializer': node.initializer?.accept(this)};
  }

  @override
  Map visitVariableDeclarationList(VariableDeclarationList node) {
    return {'type': node.type?.accept(this), 'variables': accept(node.variables, this)};
  }

  @override
  Map visitTypeName(TypeName node) {
    return {'name': node.name.name};
  }

  @override
  Map visitSimpleIdentifier(SimpleIdentifier node) {
    return {'identifier': node.name};
  }

  @override
  Map visitBinaryExpression(BinaryExpression node) {
    return {
      'operation': node.operator.lexeme,
      'leftParams': node.leftOperand.accept(this),
      'rightParams': node.rightOperand.accept(this)
    };
  }

  @override
  Map visitIntegerLiteral(IntegerLiteral node) {
    return {'value': node.value};
  }

  List<Map> accept(elements, AstVisitor visitor) {
    List<Map> list = [];
    for (var i = 0; i < elements.length; i++) {
      Map res = elements[i].accept(visitor);
      list.add(res);
    }
    return list;
  }
}
