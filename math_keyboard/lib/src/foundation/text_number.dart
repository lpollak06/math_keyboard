import 'package:math_expressions/math_expressions.dart';

/// A number literal that preserves its original textual representation.
///
/// This is useful when numbers must round-trip without losing precision
/// (e.g. "0.99999999999999999999" should not become "1").
class TextNumber extends Number {
  /// The exact text used to create this number.
  final String text;

  /// Creates a [TextNumber] while still providing a numeric value to the
  /// underlying [Number] for evaluation.
  TextNumber(this.text) : super(_parseText(text));

  @override
  String toString() => _normalizeText(text);

  static String _normalizeText(String text) {
    var normalized = text.trim();
    if (normalized.startsWith('.')) {
      normalized = '0$normalized';
    }
    if (normalized.endsWith('.')) {
      normalized = '${normalized}0';
    }
    return normalized;
  }

  static double _parseText(String text) {
    // Use double parsing for evaluation compatibility. The exact string is
    // preserved in [text] and used for output.
    return double.parse(text);
  }
}
