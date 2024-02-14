import 'dart:io';

import 'package:eGrocer/resources/resources.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('app_images assets test', () {
    expect(File(AppImages.annaPelzer).existsSync(), isTrue);
    expect(File(AppImages.brookeLark).existsSync(), isTrue);
    expect(File(AppImages.carousel).existsSync(), isTrue);
    expect(File(AppImages.categories).existsSync(), isTrue);
    expect(File(AppImages.defaultImages).existsSync(), isTrue);
    expect(File(AppImages.earth).existsSync(), isTrue);
    expect(File(AppImages.horse).existsSync(), isTrue);
    expect(File(AppImages.lilyBanse).existsSync(), isTrue);
    expect(File(AppImages.location).existsSync(), isTrue);
    expect(File(AppImages.moto).existsSync(), isTrue);
    expect(File(AppImages.person).existsSync(), isTrue);
    expect(File(AppImages.pin).existsSync(), isTrue);
    expect(File(AppImages.products).existsSync(), isTrue);
    expect(File(AppImages.prototype).existsSync(), isTrue);
  });
}
