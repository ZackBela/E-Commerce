import 'package:flutter_test/flutter_test.dart';
import 'package:e_commerce/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('PrincipalViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
