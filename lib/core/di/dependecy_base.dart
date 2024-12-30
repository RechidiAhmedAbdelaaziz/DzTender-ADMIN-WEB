part of 'container.dart';

abstract class DependencyBase {
  final injector = locator;

  void init();

  static Future<void> _init() async {
    final dependencies = [
      AuthDependency(),
      TenderDependency(),
      NewspaperDependency(),
    ];

    for (final dependency in dependencies) {
      dependency.init();
    }
  }
}
