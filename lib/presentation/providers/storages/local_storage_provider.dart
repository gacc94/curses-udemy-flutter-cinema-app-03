import 'package:cinema_app_03/domain/repositories/local_storage_repository.dart';
import 'package:cinema_app_03/infrastructure/datasources/drift_datasource.dart';
import 'package:cinema_app_03/infrastructure/repositories/local_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStoragesRepositoryProvider = Provider<LocalStorageRepository>((ref) {
  return LocalStorageRepositoryImpl(DriftDatasource());
});
