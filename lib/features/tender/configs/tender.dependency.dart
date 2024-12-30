import 'package:tender/core/di/container.dart';
import 'package:tender/features/tender/data/repo/tender.repo.dart';
import 'package:tender/features/tender/data/source/tender.api.dart';

class TenderDependency extends DependencyBase {
  @override
  void init() {
    injector.registerLazySingleton(() => TenderApi(injector()));
    injector.registerLazySingleton(() => TenderRepo());
  }
}
