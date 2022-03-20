import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'filterable_list.dart';

class SearchSuggestions extends StatefulWidget implements PreferredSizeWidget {
  final void Function(dynamic, Type) onTapped;
  final void Function(String, Type) onSearch;
  final Future<List<dynamic>> Function(String value) suggestions;
  final Color? suggestionBackgroundColor;
  final Duration debounceDuration;
  final Widget Function(
    TextEditingController controller,
    FocusNode focusNode,
    void Function(String value) onSubmitted,
    void Function() onCancel,
    bool canCancel,
  ) builderTextField;
  final Widget Function(
    List<dynamic> items,
    void Function(String) onItemTapped,
    void Function() onViewAllPressed,
  ) builderSuggestions;

  const SearchSuggestions({
    Key? key,
    required this.onTapped,
    required this.onSearch,
    required this.suggestions,
    required this.builderTextField,
    required this.builderSuggestions,
    this.suggestionBackgroundColor,
    this.debounceDuration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  State<SearchSuggestions> createState() => _SearchSuggestionsState();

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _SearchSuggestionsState extends State<SearchSuggestions>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  bool _isLoading = false;
  bool _isOpen = false;
  bool _canCancel = false;
  OverlayEntry? _overlayEntry;
  List<dynamic> _suggestions = [];
  Timer? _debounce;
  String _previousAsyncSearchText = '';
  final FocusNode _focusNode = FocusNode();

  final TextEditingController _searchController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _canCancel = true;
        setState(() {});
      } else {
        _canCancel = false;
        _debounce?.cancel();
        if (_isOpen) {
          _searchController.clear();
          _toggleDropdown(close: true);
        }
        setState(() {});
      }
    });
    _searchController.addListener(() async {
      if (_searchController.text.isNotEmpty) {
        _toggleDropdown();
        updateSuggestions(_searchController.text);
      } else {
        _previousAsyncSearchText = '';
        _toggleDropdown(close: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.builderTextField(
        _searchController,
        _focusNode,
        (_) => _search(),
        () {
          setState(() {});
          _searchController.clear();
          _focusNode.unfocus();
          _toggleDropdown(close: true);
        },
        _canCancel,
      ),
    );
  }

  void _search() {
    setState(() {});
    final type = _suggestions.isEmpty || _suggestions.first == null
        ? Null
        : _suggestions.first.runtimeType;
    if (type != Null) {
      widget.onSearch(_searchController.text, type);
    }
    _searchController.clear();
    _focusNode.unfocus();
    _toggleDropdown(close: true);
  }

  OverlayEntry _openOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height,
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height),
                child: SizeTransition(
                  axisAlignment: 1,
                  sizeFactor: _expandAnimation,
                  child: FilterableList(
                    loading: _isLoading,
                    items: _suggestions,
                    builderSuggestions: widget.builderSuggestions,
                    suggestionBackgroundColor: widget.suggestionBackgroundColor,
                    onViewAllPressed: _search,
                    onItemTapped: (value) {
                      final type = _suggestions.first == null
                          ? Null
                          : _suggestions.first.runtimeType;
                      if (type != Null) {
                        widget.onTapped(value, type);
                      }
                      _searchController.clear();
                      _focusNode.unfocus();
                      _toggleDropdown(close: true);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleDropdown({bool close = false}) async {
    if (close) {
      await _animationController.reverse();
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isOpen = false;
      setState(() {});
    } else {
      _overlayEntry = _openOverlay();
      Overlay.of(context)?.insert(_overlayEntry!);
      _isOpen = true;
      setState(() {});
      _animationController.forward();
    }
  }

  void updateSuggestions(String text) async {
    _debounce?.cancel();
    _isLoading = true;
    setState(() {});
    _debounce = Timer(widget.debounceDuration, () async {
      final searchText = text.isNotEmpty ? text : null;
      if (searchText == _previousAsyncSearchText) return;
      _suggestions = await widget.suggestions(text);
      _isLoading = false;
      _previousAsyncSearchText = text;
      setState(() {});
      rebuildOverlay();
    });
  }

  void rebuildOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
