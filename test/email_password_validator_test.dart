import 'package:flutter_test/flutter_test.dart';
import '../lib/login_page.dart';

void main() {
  test('empty mail returns error string', () {
    var result = EmailFieldValidator.validate('');
    expect(result, 'Email can\'t be empty');
  });

  test('empty password returns error string', () {
    var result = PasswordFieldValidator.validate('');
    expect(result, 'Password can\'t be empty');
  });

  test('non-empty emails return null', () {
    var result = EmailFieldValidator.validate('test@test.com');
    expect(result, null);
  });

  test('non-empty passwords return null', () {
    var result = PasswordFieldValidator.validate('password');
    expect(result, null);
  });
}
