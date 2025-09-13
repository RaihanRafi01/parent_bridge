import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

typedef DisplayChange = void Function(bool isOpen);

/// Widget providing the circular FAB menu
/// both the invoke button and the circular menu
class CircularMenu extends StatefulWidget {
  /// List of the menu items in the circular menu
  final List<Widget> children;

  /// Alignment of the menu invoke button
  /// and also the ring of the circular menu items
  final Alignment alignment;

  /// Gradient of the circular menu items' ring background
  final Gradient? ringGradient;

  /// Diameter of the circular menu items' ring
  final double? ringDiameter;

  /// Limit factor of the circular menu items' ring diameter
  final double ringDiameterLimitFactor;

  /// Width of the circular menu items' ring
  final double? ringWidth;

  /// Limit factor of the circular menu items' ring width
  final double ringWidthLimitFactor;

  /// Size of the FAB button
  final double fabSize;

  /// Elevation of the FAB button
  final double fabElevation;

  /// Gradient of the FAB button
  final Gradient? fabGradient;

  /// Gradient of the FAB button when opening
  final Gradient? fabOpenGradient;

  /// Gradient of the FAB button when closing
  final Gradient? fabCloseGradient;

  /// Widget child of the FAB button (optional, for complete customization)
  final Widget? fabChild;

  /// Open icon of the FAB button
  final Widget fabOpenIcon;

  /// Close icon of the FAB button
  final Widget fabCloseIcon;

  /// Border shape of the FAB button icon
  final ShapeBorder? fabIconBorder;

  /// Margins of the FAB button
  final EdgeInsets fabMargin;

  /// FAB open / close animation duration
  final Duration animationDuration;

  /// FAB open / close animation curve
  final Curve animationCurve;

  /// Display change callback of FAB menu open / close
  final DisplayChange? onDisplayChange;

  CircularMenu({
    Key? key,
    this.alignment = Alignment.bottomRight,
    this.ringGradient,
    this.ringDiameter,
    this.ringDiameterLimitFactor = 1.5,
    this.ringWidth,
    this.ringWidthLimitFactor = 0.2,
    this.fabSize = 64.0,
    this.fabElevation = 8.0,
    this.fabGradient,
    this.fabOpenGradient,
    this.fabCloseGradient,
    this.fabIconBorder,
    this.fabChild,
    this.fabOpenIcon = const Icon(Icons.add),
    this.fabCloseIcon = const Icon(Icons.close),
    this.fabMargin = const EdgeInsets.all(16.0),
    this.animationDuration = const Duration(milliseconds: 800),
    this.animationCurve = Curves.easeInOutCirc,
    this.onDisplayChange,
    required this.children,
  })  : assert(children.isNotEmpty),
        super(key: key);

  @override
  FabCircularMenuPlusState createState() => FabCircularMenuPlusState();
}

class FabCircularMenuPlusState extends State<CircularMenu>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late double _screenWidth;
  late double _screenHeight;
  late double _marginH;
  late double _marginV;
  late double _directionX;
  late double _directionY;
  late double _translationX;
  late double _translationY;

  Gradient? _ringGradient;
  double? _ringDiameter;
  double? _ringWidth;
  Gradient? _fabGradient;
  Gradient? _fabOpenGradient;
  Gradient? _fabCloseGradient;
  late ShapeBorder _fabIconBorder;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation _scaleCurve;
  late Animation<double> _rotateAnimation;
  late Animation _rotateCurve;
  late Animation<double> _colorAnimation;
  late Animation _colorCurve;

  bool _isOpen = false;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _animationController =
        AnimationController(duration: widget.animationDuration, vsync: this);

    _scaleCurve = CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.4, curve: widget.animationCurve));
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(_scaleCurve as Animation<double>)
      ..addListener(() {
        setState(() {});
      });

    _rotateCurve = CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.4, 1.0, curve: widget.animationCurve));
    _rotateAnimation = Tween<double>(begin: 0.5, end: 1.0)
        .animate(_rotateCurve as Animation<double>)
      ..addListener(() {
        setState(() {});
      });

    _colorCurve = CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.4, curve: widget.animationCurve));
    _colorAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(_colorCurve as Animation<double>)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    _calculateProps();
    if (isOpen) {
      close();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _calculateProps();
  }

  @override
  Widget build(BuildContext context) {
    // This makes the widget able to correctly redraw on
    // hot reload while keeping performance in production
    if (!kReleaseMode) {
      _calculateProps();
    }

    // Interpolate between fabCloseGradient and fabOpenGradient based on animation
    final Gradient effectiveGradient = _interpolateGradients(
      _fabCloseGradient!,
      _fabOpenGradient!,
      _colorAnimation.value,
    );

    return OrientationBuilder(
      builder: (context, orientation) {
        return Stack(
          alignment: widget.alignment,
          children: <Widget>[
            OverflowBox(
              maxWidth: _ringDiameter,
              maxHeight: _ringDiameter,
              child: Transform(
                transform: Matrix4.translationValues(
                  _translationX,
                  _translationY,
                  0.0,
                )..scale(_scaleAnimation.value),
                alignment: FractionalOffset.center,
                child: SizedBox(
                  width: _ringDiameter,
                  height: _ringDiameter,
                  child: CustomPaint(
                    painter: _RingPainter(
                      width: _ringWidth,
                      gradient: _ringGradient,
                    ),
                    child: _scaleAnimation.value == 1.0
                        ? Transform.rotate(
                      angle: (2 * math.pi) *
                          _rotateAnimation.value *
                          _directionX *
                          _directionY,
                      child: Stack(
                        alignment: Alignment.center,
                        children: widget.children
                            .asMap()
                            .map((index, child) => MapEntry(
                            index, _applyTransformations(child, index)))
                            .values
                            .toList(),
                      ),
                    )
                        : Container(),
                  ),
                ),
              ),
            ),
            // FAB
            Container(
              width: widget.fabSize,
              height: widget.fabSize,
              margin: widget.fabMargin,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: _isOpen ?Colors.transparent:Colors.white
                )
              ),
              child: Material(
                elevation: widget.fabElevation,
                shape: _fabIconBorder,
                clipBehavior: Clip.antiAlias,
                child: DecoratedBox(
                  decoration: BoxDecoration(

                    gradient: effectiveGradient,
                  ),
                  child: RawMaterialButton(
                    onPressed: () {
                      if (_isAnimating) return;

                      if (_isOpen) {
                        close();
                      } else {
                        open();
                      }
                    },
                    child: Center(
                      child: widget.fabChild ??
                          (_scaleAnimation.value == 1.0
                              ? widget.fabCloseIcon
                              : widget.fabOpenIcon),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _applyTransformations(Widget child, int index) {
    // Calculate the angle for each child FAB to spread them evenly in a 180-degree semicircle
    // Starting from -180 degrees (left) to 0 degrees (right)
    final double angle =
        -math.pi + (math.pi / (widget.children.length - 1)) * index;

    return Transform(
      transform: Matrix4.translationValues(
        (_ringDiameter! / 2 - _ringWidth! / 2) * math.cos(angle) * _directionX,
        (_ringDiameter! / 2 - _ringWidth! / 2) * math.sin(angle) * _directionY,
        0.0,
      ),
      alignment: FractionalOffset.center,
      child: Material(
        color: Colors.transparent,
        child: child,
      ),
    );
  }

  void _calculateProps() {
    _ringGradient = widget.ringGradient ??
        SweepGradient(
          colors: [
            Colors.grey.withOpacity(0.5),
            Colors.blue.withOpacity(0.5),
            Colors.grey.withOpacity(0.5),
          ],
          stops: [0.0, 0.5, 1.0],
        );
    _fabGradient = widget.fabGradient ??
        LinearGradient(
          colors: [Colors.white, Colors.white],
        );
    _fabOpenGradient = widget.fabOpenGradient ?? _fabGradient;
    _fabCloseGradient = widget.fabCloseGradient ?? _fabGradient;
    _fabIconBorder = widget.fabIconBorder ?? const CircleBorder();
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    _ringDiameter = widget.ringDiameter ??
        math.min(_screenWidth, _screenHeight) * widget.ringDiameterLimitFactor;
    _ringWidth =
        widget.ringWidth ?? _ringDiameter! * widget.ringWidthLimitFactor;
    _marginH = (widget.fabMargin.right + widget.fabMargin.left) / 2;
    _marginV = (widget.fabMargin.top + widget.fabMargin.bottom) / 2;
    _directionX = widget.alignment.x == 0 ? 1 : 1 * widget.alignment.x.sign;
    _directionY = widget.alignment.y == 0 ? 1 : 1 * widget.alignment.y.sign;
    _translationX =
        ((_screenWidth - widget.fabSize) / 2 - _marginH) * widget.alignment.x;
    _translationY =
        ((_screenHeight - widget.fabSize) / 2 - _marginV) * widget.alignment.y;
  }

  Gradient _interpolateGradients(Gradient start, Gradient end, double t) {
    // Assume LinearGradient for FAB; extend for other gradient types if needed
    if (start is LinearGradient && end is LinearGradient) {
      final List<Color> interpolatedColors = [];
      final int maxLength =
      math.max(start.colors.length, end.colors.length);

      for (int i = 0; i < maxLength; i++) {
        final Color startColor =
        i < start.colors.length ? start.colors[i] : start.colors.last;
        final Color endColor =
        i < end.colors.length ? end.colors[i] : end.colors.last;
        interpolatedColors.add(Color.lerp(startColor, endColor, t)!);
      }

      final List<double>? interpolatedStops;
      if (start.stops != null && end.stops != null) {
        interpolatedStops = [];
        for (int i = 0; i < maxLength; i++) {
          final double startStop =
          i < start.stops!.length ? start.stops![i] : start.stops!.last;
          final double endStop =
          i < end.stops!.length ? end.stops![i] : end.stops!.last;
          interpolatedStops.add(lerpDouble(startStop, endStop, t)!);
        }
      } else {
        interpolatedStops = null;
      }

      return LinearGradient(
        begin: start.begin,
        end: start.end,
        colors: interpolatedColors,
        stops: interpolatedStops,
        tileMode: start.tileMode,
      );
    }
    // Fallback to start gradient if types don't match
    return start;
  }

  void open() {
    _isAnimating = true;
    _animationController.forward().then((_) {
      _isAnimating = false;
      _isOpen = true;
      if (widget.onDisplayChange != null) {
        widget.onDisplayChange!(true);
      }
    });
  }

  void close() {
    _isAnimating = true;
    _animationController.reverse().then((_) {
      _isAnimating = false;
      _isOpen = false;
      if (widget.onDisplayChange != null) {
        widget.onDisplayChange!(false);
      }
    });
  }

  bool get isOpen => _isOpen;
}

class _RingPainter extends CustomPainter {
  final double? width;
  final Gradient? gradient;

  _RingPainter({required this.width, this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = gradient?.createShader(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2,
        ),
      )
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width < width! ? size.width : width!;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}