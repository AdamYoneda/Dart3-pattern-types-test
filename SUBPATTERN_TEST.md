# テスト実行結果

このドキュメントでは、Dart 3のパターンマッチングにおける`case var s?`と`case var s!`の動作テストの実行方法と期待する結果を詳細に記載します。

## テスト環境

- **Dart SDK version**: 3.7.2
- **テストファイル**: `bin/subpattern_test.dart`

## テスト実行コマンド

```bash
dart run subpattern_test.dart
```

## 期待する実行結果（完全版）

```

# dart run subpattern_test.dart...

## Test 1: null-check pattern (case var s?)
  Testing: non-null (value: nullable with base type String)
    ✓ Matched! s = "nullable with base type String" (type: String)
    ✓ Safe to use: s.length = 30
  Testing: null (value: null)
    ✓ Matched null case

................................................................................

## Test 2: null-assert pattern (case var s!)
  Testing: non-null (value: nullable with base type String)
    ✓ Matched! s = "nullable with base type String" (type: String)
    ✓ Safe to use: s.length = 30
  Testing: null (value: null)
    ✗ Exception thrown: Null check operator used on a null value
    ✗ UNSAFE: Throws on null value!

................................................................................

## Summary:
- case var s?: Safe - only matches non-null values
- case var s!: Unsafe - throws exception on null

```

### Reference
- [Dart Pattern Types](https://dart.dev/language/pattern-types)
- [Pattern Types - `subpattern?`](https://dart.dev/language/pattern-types?utm_source=chatgpt.com#null-check)
