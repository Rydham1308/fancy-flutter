
import 'package:fancy/healper/dio_singleton.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void initializeSingletons() {
  getIt
    .registerSingleton<DioClient>(
      DioClient()
    );
}