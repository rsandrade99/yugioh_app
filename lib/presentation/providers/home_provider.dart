import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/carta_remote_data_source.dart';
import '../../data/repositories/carta_repository.dart';
import '../views/home/home_viewmodel.dart';

final cardRemoteDataSourceProvider = Provider<CartaRemoteDataSource>((ref) {
  return CartaRemoteDataSource();
});

final cardRepositoryProvider = Provider<CardRepository>((ref) {
  final dataSource = ref.read(cardRemoteDataSourceProvider);
  return CardRepository(remoteDataSource: dataSource);
});

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>((
  ref,
) {
  final repo = ref.read(cardRepositoryProvider);
  return HomeViewModel(repo);
});
