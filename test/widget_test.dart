import 'package:flutter_test/flutter_test.dart';
import 'package:happ/views/onboarding/onboarding_view_model.dart';

void main() {
  test('Test Name', () {
    String name1 = 'Test Name';
    expect(OnboardingViewModel.isValidName(name1), true);

    String name2 = 'Test1';
    expect(OnboardingViewModel.isValidName(name2), false);
  });
}
