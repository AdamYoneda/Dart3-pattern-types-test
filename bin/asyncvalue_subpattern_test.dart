import 'package:riverpod/riverpod.dart';

void main() {
  print(
      '\n# dart run asyncvalue_subpattern_riverpod_test.dart (Riverpod AsyncValue)...\n');

  print('## Test A: AsyncValue with null-check (value: final v?)');
  testClassPatternWithNullCheck();

  print('\n' + '.' * 80 + '\n');

  print('## Test B: AsyncValue with null-assert (value: final v!)');
  testClassPatternWithNullAssert();

  print('\n' + '.' * 80 + '\n');

  print('## Summary:');
  print('- AsyncData(value: final v?): 非 null のときだけマッチ、v は非 null 型で束縛 → 例外なし');
  print('- AsyncData(value: final v!): null を含むとパターン照合中に例外（Unsafe）');
}

/// Test A: Null-check subpattern (value: final v?)
/// https://dart.dev/language/pattern-types#null-check
void testClassPatternWithNullCheck() {
  final cases = <AsyncValue<String?>>[
    const AsyncValue<String?>.data('non-null'), // 非 null
    const AsyncValue<String?>.data(null), // null
    const AsyncValue<String?>.error('error', StackTrace.empty), // AsyncError
    const AsyncValue<String?>.loading(), // AsyncLoading
  ];

  for (final value in cases) {
    try {
      final msg = switch (value) {
        // null の場合はマッチせずに次のケースへ
        AsyncData(value: final v?, :final isLoading) =>
          '✓ AsyncData matched with v="$v", isLoading=$isLoading',
        AsyncData(value: null) => '✓ AsyncData matched with null value',
        AsyncError(error: final e, stackTrace: final s) =>
          '✓ AsyncError matched with error="$e", stackTrace=$s',
        _ => '✓ Fallback',
      };
      print('  $msg');
    } catch (e) {
      print('  ✗ Exception thrown during matching: $e');
      print('    ✗ UNSAFE: Throws when value is null');
    }
  }
}

/// Test B: Null-assert (value: final v!)
/// https://dart.dev/language/pattern-types#null-assert
void testClassPatternWithNullAssert() {
  final cases = <AsyncValue<String?>>[
    const AsyncValue<String?>.data('non-null'), // 非 null
    const AsyncValue<String?>.data(null), // null
    const AsyncValue<String?>.error('error', StackTrace.empty), // AsyncError
    const AsyncValue<String?>.loading(), // AsyncLoading
  ];

  for (final value in cases) {
    try {
      final msg = switch (value) {
        // null の場合は照合中に例外（TypeError）が投げられる
        AsyncData(value: final v!, :final isLoading) =>
          '✓ AsyncData matched with v="$v", isLoading=$isLoading',
        AsyncError(error: final e, stackTrace: final s) =>
          '✓ AsyncError matched with error="$e", stackTrace=$s',
        _ => '✓ Fallback',
      };
      print('  $msg');
    } catch (e) {
      print('  ✗ Exception thrown during matching: $e');
      print('    ✗ UNSAFE: Throws when value is null');
    }
  }
}
