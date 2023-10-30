class A {
  printMessage() => print('A');
}

mixin B on A {
  @override
  printMessage() {
    print("B_in");
    super.printMessage();
    print("B_out");
  }
}

mixin C on B {
  @override
  printMessage() {
    print("C_in");
    super.printMessage();
    print("C_out");
  }
}

class D with A, B, C {
  @override
  printMessage() {
    print('D_in');
    super.printMessage();
    print('D_out');
  }
}

void main() {
  D().printMessage();
}