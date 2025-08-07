import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/carta_repository.dart';
import '../../../domain/entities/carta_entity.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  final CardRepository _repository;
  int _page = 0;
  final int _limit = 10;

  HomeViewModel(this._repository) : super(HomeState.initial()) {
    obtenerMasCartas(); // carga inicial
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  Future<void> obtenerMasCartas() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);
    try {
      final newCards = await _repository.getCartas(
        offset: _page * _limit,
        limit: _limit,
      );
      _page++;
      state = state.copyWith(
        cards: [...state.cartas, ...newCards],
        isLoading: false,
        hasMore: newCards.length == _limit,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refrescarCartas() async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      cards: [],
      hasMore: true,
    );
    _page = 0;
    try {
      final freshCards = await _repository.getCartas(offset: 0, limit: _limit);
      _page++;
      state = state.copyWith(
        cards: freshCards,
        isLoading: false,
        hasMore: freshCards.length == _limit,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

class HomeState {
  final List<CartaEntity> cartas;
  final bool isLoading;
  final bool hasMore;
  final String? error;
  final String query;

  HomeState({
    required this.cartas,
    required this.isLoading,
    required this.hasMore,
    this.error,
    this.query = '',
  });

  factory HomeState.initial() => HomeState(
    cartas: [],
    isLoading: false,
    hasMore: true,
    error: null,
    query: '',
  );

  HomeState copyWith({
    List<CartaEntity>? cards,
    bool? isLoading,
    bool? hasMore,
    String? error,
    String? searchQuery,
  }) {
    return HomeState(
      cartas: cards ?? cartas,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      error: error ?? this.error,
      query: searchQuery ?? query,
    );
  }
}
