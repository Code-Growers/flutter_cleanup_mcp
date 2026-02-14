import 'dart:async'; // Unused import

void main() {
  var unusedLocal = 'I am unused'; // Unused local variable
  print('Hello');
}

void _unusedFunction() { // Unused function
  print('I am unused');
}

class _UnusedClass { // Unused class
  String _unusedField = 'unused'; // Unused field
}
