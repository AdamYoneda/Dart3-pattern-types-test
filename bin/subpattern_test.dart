void main() {
  print('\n# dart run subpattern_test.dart...\n');

  // Test 1: null-check pattern (?)
  print('## Test 1: null-check pattern (case var s?)');
  testNullCheckPattern();

  print('\n' + '.' * 80 + '\n');

  // Test 2: null-assert pattern (!)
  print('## Test 2: null-assert pattern (case var s!)');
  testNullAssertPattern();

  print('\n' + '.' * 80 + '\n');

  // Summary
  print('## Summary:');
  print('- case var s?: Safe - only matches non-null values');
  print('- case var s!: Unsafe - throws exception on null');
}

/// Test null-check pattern (?): Safe pattern
void testNullCheckPattern() {
  final testCases = [
    ('nullable with base type String', 'non-null'),
    (null, 'null'),
  ];

  for (final (value, description) in testCases) {
    print('  Testing: $description (value: $value)');
    String? maybeString = value;

    try {
      switch (maybeString) {
        case var s?:
          // s has type non-nullable String here
          print('    ✓ Matched! s = "$s" (type: ${s.runtimeType})');
          print('    ✓ Safe to use: s.length = ${s.length}');
        case null:
          print('    ✓ Matched null case');
      }
    } catch (e) {
      print('    ✗ Exception: $e');
    }
  }
}

/// Test null-assert pattern (!): Potentially unsafe pattern
void testNullAssertPattern() {
  final testCases = [
    ('nullable with base type String', 'non-null'),
    (null, 'null'),
  ];

  for (final (value, description) in testCases) {
    print('  Testing: $description (value: $value)');
    String? maybeString = value;

    try {
      switch (maybeString) {
        case var s!:
          // s has type non-nullable String here
          print('    ✓ Matched! s = "$s" (type: ${s.runtimeType})');
          print('    ✓ Safe to use: s.length = ${s.length}');
      }
    } catch (e) {
      print('    ✗ Exception thrown: $e');
      print('    ✗ UNSAFE: Throws on null value!');
    }
  }
}
