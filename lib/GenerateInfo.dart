// 1、Dart 注解累和普通类是一样
// 2、只需要注意一点：一定要有 const 构造器
// 3、支持构造器传参，有参数可以在 builder 的时候拿到参数
class GenerateInfo {
  final String value;

  const GenerateInfo(this.value);
}
