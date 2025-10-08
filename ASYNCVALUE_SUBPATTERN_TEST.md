# AsyncValue サブパターンテスト実行結果

このドキュメントでは、Dart 3のパターンマッチングにおけるRiverpod `AsyncValue`と`null-check`サブパターン（`value: final v?`）および`null-assert`サブパターン（`value: final v!`）の動作テストの実行方法と期待する結果を詳細に記載します。

## テスト環境

- **Dart SDK version**: 3.7.2
- **テストファイル**: `bin/asyncvalue_subpattern_test.dart`
- **依存関係**: Riverpod package

## テスト実行コマンド

```bash
dart run asyncvalue_subpattern_test.dart
```

## 期待する実行結果（完全版）

```text

# dart run asyncvalue_subpattern_riverpod_test.dart (Riverpod AsyncValue)...

## Test A: AsyncValue with null-check (value: final v?)
  ✓ AsyncData matched with v="non-null", isLoading=false
  ✓ AsyncData matched with null value
  ✓ AsyncError matched with error="error", stackTrace=
  ✓ Fallback

................................................................................

## Test B: AsyncValue with null-assert (value: final v!)
  ✓ AsyncData matched with v="non-null", isLoading=false
  ✗ Exception thrown during matching: Null check operator used on a null value
    ✗ UNSAFE: Throws when value is null
  ✓ AsyncError matched with error="error", stackTrace=
  ✓ Fallback

................................................................................

## Summary:
- AsyncData(value: final v?): 非 null のときだけマッチ、v は非 null 型で束縛 → 例外なし
- AsyncData(value: final v!): null を含むとパターン照合中に例外（Unsafe）
```

### Reference

- [Dart Pattern Types](https://dart.dev/language/pattern-types)
- [Pattern Types - `subpattern?`](https://dart.dev/language/pattern-types#null-check)
- [Riverpod AsyncValue](https://github.com/rrousselGit/riverpod/blob/riverpod-v2.6.1/packages/riverpod/lib/src/common.dart)
