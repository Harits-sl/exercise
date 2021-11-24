import 'package:exercise/helpers/string_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('String Helper', () {
    test('Should add comma', () {
      final int input = 1000;

      final addComma = StringHelper.addComma(input.toString());

      expect(addComma, '1,000');
    });

    test('Should To title case', () {
      final String input = 'hello dunia';

      final toTitleCase = StringHelper.toTitleCase(input);

      expect(toTitleCase, 'Hello Dunia');
    });
  });
}
