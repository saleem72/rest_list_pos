//

import 'dart:convert';

class PrettyJson {
  PrettyJson._();

  static JsonDecoder decoder = const JsonDecoder();
  static JsonEncoder encoder = const JsonEncoder.withIndent('  ');

  static String print(String input) {
    var object = decoder.convert(input);
    var prettyString = encoder.convert(object);
    return prettyString;
    // print(prettyString);
    // prettyString.split('\n').forEach((element) => print(element));
  }
}
