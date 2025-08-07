import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../providers/home_provider.dart';
import '../../widgets/organisms/wid_carta_item.dart';
import 'carta_detalle.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final provider = ref.read(homeViewModelProvider.notifier);
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !ref.read(homeViewModelProvider).isLoading) {
      provider.obtenerMasCartas();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);

    final filteredCards = state.query.isEmpty
        ? state.cartas
        : state.cartas
              .where(
                (card) =>
                    card.name.toLowerCase().contains(state.query.toLowerCase()),
              )
              .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade900,
        elevation: 6,
        centerTitle: true,
        title: const Text(
          'Yu-Gi-Oh! Cards',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontSize: 22,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        shadowColor: Colors.deepPurpleAccent.withOpacity(0.6),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchBarHeaderDelegate(
              child: SearchBar(
                initialValue: state.query,
                onChanged: (value) {
                  ref
                      .read(homeViewModelProvider.notifier)
                      .setSearchQuery(value);
                },
              ),
            ),
          ),
          if (state.error != null)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.redAccent,
                      size: 60,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Oops... algo salió mal',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.error!,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () {
                        ref
                            .read(homeViewModelProvider.notifier)
                            .refrescarCartas();
                      },
                    ),
                  ],
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index < filteredCards.length) {
                  final card = filteredCards[index];
                  return CartaItem(
                    card: card,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => DetalleCartaDialog(card: card),
                      );
                    },
                  ).animate().fadeIn(duration: 300.ms);
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Center(child: CircularProgressIndicator()),
                  ).animate().fadeIn();
                }
              }, childCount: filteredCards.length + (state.hasMore ? 1 : 0)),
            ),
        ],
      ),
    );
  }
}

class _SearchBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SearchBarHeaderDelegate({required this.child});

  @override
  double get minExtent => 70;

  @override
  double get maxExtent => 70;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      alignment: Alignment.center,
      child: child,
      decoration: BoxDecoration(
        //  color: Colors.deepPurple.shade900,
        boxShadow: [
          if (shrinkOffset > 0)
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(0, 3),
              blurRadius: 6,
            ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SearchBarHeaderDelegate oldDelegate) =>
      oldDelegate.child != child;
}

class SearchBar extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const SearchBar({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant SearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Mantener sincronizado el controlador si cambia el valor externo
    if (widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
      // Mueve el cursor al final para no “romper” la experiencia
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      cursorColor: Colors.deepPurpleAccent,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.deepPurple.shade700.withOpacity(0.85),
        hintText: 'Buscar carta...',
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        prefixIcon: const Icon(Icons.search, color: Colors.white70),
        suffixIcon: _controller.text.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  _controller.clear();
                  widget.onChanged('');
                  FocusScope.of(context).unfocus();
                },
                child: const Icon(Icons.close, color: Colors.white70),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onChanged: widget.onChanged,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
    );
  }
}
