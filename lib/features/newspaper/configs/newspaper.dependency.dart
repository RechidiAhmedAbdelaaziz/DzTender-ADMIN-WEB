import 'package:tender/core/di/container.dart';
import 'package:tender/features/newspaper/data/api/newspaper.api.dart';
import 'package:tender/features/newspaper/data/rep/newspaper.repo.dart';

class NewspaperDependency extends DependencyBase {
  @override
  void init() {
    injector.registerLazySingleton(() => NewsPaperApi(locator()));
    injector.registerLazySingleton(() => NewsPaperRepo());
  }
}
