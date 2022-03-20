import 'package:flutter/material.dart';

class CustomDropdownWidget<T> extends StatefulWidget {
  final Widget Function(
    int currentIndex,
    void Function() toggleDropdown,
  ) builderButton;
  final Widget Function(
    int currentIndex,
    void Function(int index) onTap,
  ) builderDropdown;
  final void Function(int currentIndex) onChanged;
  final int initialIndex;
  final double? widthDropdown;
  final double? heightDropdown;
  final Offset? offsetDropdown;
  final double? elevationDropdown;
  final BorderRadius? borderRadiusDropdown;
  final Color? colorDropdown;
  final EdgeInsets? paddingDropdown;
  final bool manageCurrentIndex;

  const CustomDropdownWidget({
    Key? key,
    required this.builderButton,
    required this.builderDropdown,
    required this.onChanged,
    required this.initialIndex,
    this.widthDropdown,
    this.heightDropdown,
    this.offsetDropdown,
    this.elevationDropdown,
    this.borderRadiusDropdown,
    this.colorDropdown,
    this.paddingDropdown,
    required this.manageCurrentIndex,
  }) : super(key: key);

  @override
  _CustomDropdownWidgetState<T> createState() =>
      _CustomDropdownWidgetState<T>();
}

class _CustomDropdownWidgetState<T> extends State<CustomDropdownWidget<T>>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  int _currentIndex = -1;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.manageCurrentIndex) {
      _currentIndex = widget.initialIndex;
    }
    // link the overlay to the button
    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.builderButton(_currentIndex, _toggleDropdown),
    );
  }

  OverlayEntry _createOverlayEntry() {
    // find the size and position of the current widget
    RenderBox renderBox = context.findRenderObject()! as RenderBox;
    var size = renderBox.size;

    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height;
    return OverlayEntry(
      // full screen GestureDetector to register when a
      // user has clicked away from the dropdown
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        // full screen container to register taps anywhere and close drop down
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset,
                width: widget.widthDropdown ?? size.width,
                child: CompositedTransformFollower(
                  offset: widget.offsetDropdown ?? Offset(0, size.height + 5),
                  link: _layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: widget.elevationDropdown ?? 0,
                    borderRadius:
                        widget.borderRadiusDropdown ?? BorderRadius.zero,
                    color: widget.colorDropdown,
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: _expandAnimation,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: widget.heightDropdown ?? 120,
                        ),
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            scrollbars: false,
                            overscroll: false,
                            physics: const ClampingScrollPhysics(),
                            platform: Theme.of(context).platform,
                          ),
                          child: PrimaryScrollController(
                            controller: scrollController,
                            child: Scrollbar(
                              radius: const Radius.circular(2),
                              thickness: 3,
                              isAlwaysShown: true,
                              child: Padding(
                                padding: widget.paddingDropdown ??
                                    const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                child: widget.builderDropdown(
                                  _currentIndex,
                                  onTap,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTap(int index) {
    setState(() => _currentIndex = index);
    widget.onChanged(index);
    _toggleDropdown();
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await _animationController.reverse();
      _overlayEntry?.remove();
      setState(() => _isOpen = false);
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)?.insert(_overlayEntry!);
      setState(() => _isOpen = true);
      _animationController.forward();
    }
  }
}

/// DropdownItem is just a wrapper for each child in the dropdown list.\n
/// It holds the value of the item.
class DropdownItem<T> extends StatelessWidget {
  final T value;
  final Widget child;
  final String singleValueText;

  const DropdownItem({
    Key? key,
    required this.value,
    required this.child,
    this.singleValueText = 'singleValueText no selected',
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class DropdownButtonStyle {
  final MainAxisAlignment? mainAxisAlignment;
  final RoundedRectangleBorder? shape;
  final double? elevation;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final Size? minimumSize;
  final double? width;
  final double? height;
  final Color? primaryColor;
  const DropdownButtonStyle({
    this.mainAxisAlignment,
    this.shape,
    this.elevation,
    this.backgroundColor,
    this.padding,
    this.constraints,
    this.minimumSize,
    this.width,
    this.height,
    this.primaryColor,
  });
}

class DropdownStyle {
  final BorderRadius? borderRadius;
  final double? elevation;
  final Color? color;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;

  /// position of the top left of the dropdown relative to the top left of the button
  final Offset? offset;

  ///button width must be set for this to take effect
  final double? width;

  final double? heightDropdown;

  const DropdownStyle({
    this.borderRadius,
    this.elevation,
    this.color,
    this.padding,
    this.constraints,
    this.offset,
    this.width,
    this.heightDropdown,
  });
}
