import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'dart:async';

import 'package:transformer_page_view/transformer_page_view.dart';

part 'partSwiper.dart';

typedef void SwiperOnTap(int index);

typedef Widget SwiperDataBuilder(BuildContext context, dynamic data, int index);

/// default auto play delay
const int kDefaultAutoplayDelayMs = 3000;

///  Default auto play transition duration (in millisecond)
const int kDefaultAutoplayTransactionDuration = 300;

const int kMaxValue = 2000000000;
const int kMiddleValue = 1000000000;

enum SwiperLayoutV2 { DEFAULT, STACK, TINDER, CUSTOM }

class SwiperV2 extends StatefulWidget {
  /// If set true , the pagination will display 'outer' of the 'content' container.
  final bool outer;

  /// Inner item height, this property is valid if layout=STACK or layout=TINDER or LAYOUT=CUSTOM,
  final double itemHeight;

  /// Inner item width, this property is valid if layout=STACK or layout=TINDER or LAYOUT=CUSTOM,
  final double itemWidth;

  // height of the inside container,this property is valid when outer=true,otherwise the inside container size is controlled by parent widget
  final double containerHeight;
  // width of the inside container,this property is valid when outer=true,otherwise the inside container size is controlled by parent widget
  final double containerWidth;

  /// Build item on index
  final IndexedWidgetBuilder itemBuilder;

  /// Support transform like Android PageView did
  /// `itemBuilder` and `transformItemBuilder` must have one not null
  final PageTransformer transformer;

  /// count of the display items
  final int itemCount;

  final ValueChanged<int> onIndexChanged;

  ///auto play config
  final bool autoplay;

  ///Duration of the animation between transactions (in millisecond).
  final int autoplayDelay;

  ///disable auto play when interaction
  final bool autoplayDisableOnInteraction;

  ///auto play transition duration (in millisecond)
  final int duration;

  ///horizontal/vertical
  final Axis scrollDirection;

  ///transition curve
  final Curve curve;

  /// Set to false to disable continuous loop mode.
  final bool loop;

  ///Index number of initial slide.
  ///If not set , the `Swiper` is 'uncontrolled', which means manage index by itself
  ///If set , the `Swiper` is 'controlled', which means the index is fully managed by parent widget.
  final int index;

  ///Called when tap
  final SwiperOnTap onTap;

  ///The swiper pagination plugin
  final SwiperPluginv2 pagination;

  ///the swiper control button plugin
  final SwiperPluginv2 control;

  ///other plugins, you can custom your own plugin
  final List<SwiperPluginv2> plugins;

  ///
  final SwiperControllerV2 controller;

  final ScrollPhysics physics;

  ///
  final double viewportFraction;

  /// Build in layouts
  final SwiperLayoutV2 layout;

  /// this value is valid when layout == SwiperLayout.CUSTOM
  final CustomLayoutOptionV2 customLayoutOptionV2;

  // This value is valid when viewportFraction is set and < 1.0
  final double scale;

  // This value is valid when viewportFraction is set and < 1.0
  final double fade;

  final PageIndicatorLayout indicatorLayout;

  SwiperV2({
    this.itemBuilder,
    this.indicatorLayout: PageIndicatorLayout.NONE,

    ///
    this.transformer,
    @required this.itemCount,
    this.autoplay: false,
    this.layout: SwiperLayoutV2.DEFAULT,
    this.autoplayDelay: kDefaultAutoplayDelayMs,
    this.autoplayDisableOnInteraction: true,
    this.duration: kDefaultAutoplayTransactionDuration,
    this.onIndexChanged,
    this.index,
    this.onTap,
    this.control,
    this.loop: true,
    this.curve: Curves.ease,
    this.scrollDirection: Axis.horizontal,
    this.pagination,
    this.plugins,
    this.physics,
    Key key,
    this.controller,
    this.customLayoutOptionV2,

    /// since v1.0.0
    this.containerHeight,
    this.containerWidth,
    this.viewportFraction: 1.0,
    this.itemHeight,
    this.itemWidth,
    this.outer: false,
    this.scale,
    this.fade,
  })  : assert(itemBuilder != null || transformer != null,
            "itemBuilder and transformItemBuilder must not be both null"),
        assert(
            !loop ||
                ((loop &&
                        layout == SwiperLayoutV2.DEFAULT &&
                        (indicatorLayout == PageIndicatorLayout.SCALE ||
                            indicatorLayout == PageIndicatorLayout.COLOR ||
                            indicatorLayout == PageIndicatorLayout.NONE)) ||
                    (loop && layout != SwiperLayoutV2.DEFAULT)),
            "Only support `PageIndicatorLayout.SCALE` and `PageIndicatorLayout.COLOR`when layout==SwiperLayout.DEFAULT in loop mode"),
        super(key: key);

  factory SwiperV2.children({
    List<Widget> children,
    bool autoplay: false,
    PageTransformer transformer,
    int autoplayDelay: kDefaultAutoplayDelayMs,
    bool reverse: false,
    bool autoplayDisableOnInteraction: true,
    int duration: kDefaultAutoplayTransactionDuration,
    ValueChanged<int> onIndexChanged,
    int index,
    SwiperOnTap onTap,
    bool loop: true,
    Curve curve: Curves.ease,
    Axis scrollDirection: Axis.horizontal,
    SwiperPluginv2 pagination,
    SwiperPluginv2 control,
    List<SwiperPluginv2> plugins,
    SwiperControllerV2 controller,
    Key key,
    CustomLayoutOptionV2 customLayoutOptionV2,
    ScrollPhysics physics,
    double containerHeight,
    double containerWidth,
    double viewportFraction: 1.5,
    double itemHeight,
    double itemWidth,
    bool outer: false,
    double scale: 1.2,
  }) {
    assert(children != null, "children must not be null");

    return new SwiperV2(
        transformer: transformer,
        customLayoutOptionV2: customLayoutOptionV2,
        containerHeight: containerHeight,
        containerWidth: containerWidth,
        viewportFraction: viewportFraction,
        itemHeight: itemHeight,
        itemWidth: itemWidth,
        outer: outer,
        scale: scale,
        autoplay: autoplay,
        autoplayDelay: autoplayDelay,
        autoplayDisableOnInteraction: autoplayDisableOnInteraction,
        duration: duration,
        onIndexChanged: onIndexChanged,
        index: index,
        onTap: onTap,
        curve: curve,
        scrollDirection: scrollDirection,
        pagination: pagination,
        control: control,
        controller: controller,
        loop: loop,
        plugins: plugins,
        physics: physics,
        key: key,
        itemBuilder: (BuildContext context, int index) {
          return children[index];
        },
        itemCount: children.length);
  }

  factory SwiperV2.list({
    PageTransformer transformer,
    List list,
    CustomLayoutOptionV2 customLayoutOption,
    SwiperDataBuilder builder,
    bool autoplay: false,
    int autoplayDelay: kDefaultAutoplayDelayMs,
    bool reverse: false,
    bool autoplayDisableOnInteraction: true,
    int duration: kDefaultAutoplayTransactionDuration,
    ValueChanged<int> onIndexChanged,
    int index,
    SwiperOnTap onTap,
    bool loop: true,
    Curve curve: Curves.ease,
    Axis scrollDirection: Axis.horizontal,
    SwiperPluginv2 pagination,
    SwiperPluginv2 control,
    List<SwiperPluginv2> plugins,
    SwiperControllerV2 controller,
    Key key,
    ScrollPhysics physics,
    double containerHeight,
    double containerWidth,
    double viewportFraction: 1.3,
    double itemHeight,
    double itemWidth,
    bool outer: false,
    double scale: 1.3,
  }) {
    return new SwiperV2(
        transformer: transformer,
        customLayoutOptionV2: customLayoutOption,
        containerHeight: containerHeight,
        containerWidth: containerWidth,
        viewportFraction: viewportFraction,
        itemHeight: itemHeight,
        itemWidth: itemWidth,
        outer: outer,
        scale: scale,
        autoplay: autoplay,
        autoplayDelay: autoplayDelay,
        autoplayDisableOnInteraction: autoplayDisableOnInteraction,
        duration: duration,
        onIndexChanged: onIndexChanged,
        index: index,
        onTap: onTap,
        curve: curve,
        key: key,
        scrollDirection: scrollDirection,
        pagination: pagination,
        control: control,
        controller: controller,
        loop: loop,
        plugins: plugins,
        physics: physics,
        itemBuilder: (BuildContext context, int index) {
          return builder(context, list[index], index);
        },
        itemCount: list.length);
  }

  @override
  State<StatefulWidget> createState() {
    return new _SwiperState();
  }
}

abstract class _SwiperTimerMixin extends State<SwiperV2> {
  Timer _timer;

  SwiperControllerV2 _controller;

  @override
  void initState() {
    _controller = widget.controller;
    if (_controller == null) {
      _controller = new SwiperControllerV2();
    }
    _controller.addListener(_onController);
    _handleAutoplay();
    super.initState();
  }

  void _onController() {
    switch (_controller.event) {
      case SwiperControllerV2.START_AUTOPLAY:
        {
          if (_timer == null) {
            _startAutoplay();
          }
        }
        break;
      case SwiperControllerV2.STOP_AUTOPLAY:
        {
          if (_timer != null) {
            _stopAutoplay();
          }
        }
        break;
    }
  }

  @override
  void didUpdateWidget(SwiperV2 oldWidget) {
    if (_controller != oldWidget.controller) {
      if (oldWidget.controller != null) {
        oldWidget.controller.removeListener(_onController);
        _controller = oldWidget.controller;
        _controller.addListener(_onController);
      }
    }
    _handleAutoplay();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.removeListener(_onController);
      //  _controller.dispose();
    }

    _stopAutoplay();
    super.dispose();
  }

  bool _autoplayEnabled() {
    return _controller.autoplay ?? widget.autoplay;
  }

  void _handleAutoplay() {
    if (_autoplayEnabled() && _timer != null) return;
    _stopAutoplay();
    if (_autoplayEnabled()) {
      _startAutoplay();
    }
  }

  void _startAutoplay() {
    assert(_timer == null, "Timer must be stopped before start!");
    _timer =
        Timer.periodic(Duration(milliseconds: widget.autoplayDelay), _onTimer);
  }

  void _onTimer(Timer timer) {
    _controller.next(animation: true);
  }

  void _stopAutoplay() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }
}

class _SwiperState extends _SwiperTimerMixin {
  int _activeIndex;

  TransformerPageController _pageController;

  Widget _wrapTap(BuildContext context, int index) {
    return new GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        this.widget.onTap(index);
      },
      child: widget.itemBuilder(context, index),
    );
  }

  @override
  void initState() {
    _activeIndex = widget.index ?? 0;
    if (_isPageViewLayout()) {
      _pageController = new TransformerPageController(
          initialPage: widget.index,
          loop: widget.loop,
          itemCount: widget.itemCount,
          reverse:
              widget.transformer == null ? false : widget.transformer.reverse,
          viewportFraction: widget.viewportFraction);
    }
    super.initState();
  }

  bool _isPageViewLayout() {
    return widget.layout == null || widget.layout == SwiperLayoutV2.DEFAULT;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  bool _getReverse(SwiperV2 widget) =>
      widget.transformer == null ? false : widget.transformer.reverse;

  @override
  void didUpdateWidget(SwiperV2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isPageViewLayout()) {
      if (_pageController == null ||
          (widget.index != oldWidget.index ||
              widget.loop != oldWidget.loop ||
              widget.itemCount != oldWidget.itemCount ||
              widget.viewportFraction != oldWidget.viewportFraction ||
              _getReverse(widget) != _getReverse(oldWidget))) {
        _pageController = new TransformerPageController(
            initialPage: widget.index,
            loop: widget.loop,
            itemCount: widget.itemCount,
            reverse: _getReverse(widget),
            viewportFraction: widget.viewportFraction);
      }
    } else {
      scheduleMicrotask(() {
        // So that we have a chance to do `removeListener` in child widgets.
        if (_pageController != null) {
          _pageController.dispose();
          _pageController = null;
        }
      });
    }
    if (widget.index != null && widget.index != _activeIndex) {
      _activeIndex = widget.index;
    }
  }

  void _onIndexChanged(int index) {
    setState(() {
      _activeIndex = index;
    });
    if (widget.onIndexChanged != null) {
      widget.onIndexChanged(index);
    }
  }

  Widget _buildSwiper() {
    IndexedWidgetBuilder itemBuilder;
    if (widget.onTap != null) {
      itemBuilder = _wrapTap;
    } else {
      itemBuilder = widget.itemBuilder;
    }

    if (widget.layout == SwiperLayoutV2.STACK) {
      return new _StackSwiper(
        loop: widget.loop,
        itemWidth: widget.itemWidth,
        itemHeight: widget.itemHeight,
        itemCount: widget.itemCount,
        itemBuilder: itemBuilder,
        index: _activeIndex,
        curve: widget.curve,
        duration: widget.duration,
        onIndexChanged: _onIndexChanged,
        controller: _controller,
        scrollDirection: widget.scrollDirection,
      );
    } else if (_isPageViewLayout()) {
      PageTransformer transformer = widget.transformer;
      if (widget.scale != null || widget.fade != null) {
        transformer =
            new ScaleAndFadeTransformer(scale: widget.scale, fade: widget.fade);
      }

      Widget child = new TransformerPageView(
        pageController: _pageController,
        loop: widget.loop,
        itemCount: widget.itemCount,
        itemBuilder: itemBuilder,
        transformer: transformer,
        viewportFraction: widget.viewportFraction,
        index: _activeIndex,
        duration: new Duration(milliseconds: widget.duration),
        scrollDirection: widget.scrollDirection,
        onPageChanged: _onIndexChanged,
        curve: widget.curve,
        physics: widget.physics,
        controller: _controller,
      );
      if (widget.autoplayDisableOnInteraction && widget.autoplay) {
        return new NotificationListener(
          child: child,
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollStartNotification) {
              if (notification.dragDetails != null) {
                //by human
                if (_timer != null) _stopAutoplay();
              }
            } else if (notification is ScrollEndNotification) {
              if (_timer == null) _startAutoplay();
            }

            return false;
          },
        );
      }

      return child;
    } else if (widget.layout == SwiperLayoutV2.TINDER) {
      return new _TinderSwiperV2(
        loop: widget.loop,
        itemWidth: widget.itemWidth,
        itemHeight: widget.itemHeight,
        itemCount: widget.itemCount,
        itemBuilder: itemBuilder,
        index: _activeIndex,
        curve: widget.curve,
        duration: widget.duration,
        onIndexChanged: _onIndexChanged,
        controller: _controller,
        scrollDirection: widget.scrollDirection,
      );
    } else if (widget.layout == SwiperLayoutV2.CUSTOM) {
      return new _CustomLayoutSwiperV2(
        loop: widget.loop,
        option: null,
        itemWidth: widget.itemWidth,
        itemHeight: widget.itemHeight,
        itemCount: widget.itemCount,
        itemBuilder: itemBuilder,
        index: _activeIndex,
        curve: widget.curve,
        duration: widget.duration,
        onIndexChanged: _onIndexChanged,
        controller: _controller,
        scrollDirection: widget.scrollDirection,
      );
    } else {
      return new Container();
    }
  }

  SwiperPluginConfigv2 _ensureConfig(SwiperPluginConfigv2 config) {
    if (config == null) {
      config = new SwiperPluginConfigv2(
          outer: widget.outer,
          itemCount: widget.itemCount,
          layout: widget.layout,
          indicatorLayout: widget.indicatorLayout,
          pageController: _pageController,
          activeIndex: _activeIndex,
          scrollDirection: widget.scrollDirection,
          controller: _controller,
          loop: widget.loop);
    }
    return config;
  }

  List<Widget> _ensureListForStack(
      Widget swiper, List<Widget> listForStack, Widget widget) {
    if (listForStack == null) {
      listForStack = [swiper, widget];
    } else {
      listForStack.add(widget);
    }
    return listForStack;
  }

  @override
  Widget build(BuildContext context) {
    Widget swiper = _buildSwiper();
    List<Widget> listForStack;
    SwiperPluginConfigv2 config;
    if (widget.control != null) {
      //Stack
      config = _ensureConfig(config);
      listForStack = _ensureListForStack(
          swiper, listForStack, widget.control.buildv2(context, config));
    }

    if (widget.plugins != null) {
      config = _ensureConfig(config);
      for (SwiperPluginv2 plugin in widget.plugins) {
        listForStack = _ensureListForStack(
            swiper, listForStack, plugin.buildv2(context, config));
      }
    }
    if (widget.pagination != null) {
      config = _ensureConfig(config);
      if (widget.outer) {
        return _buildOuterPagination(
            widget.pagination,
            listForStack == null ? swiper : new Stack(children: listForStack),
            config);
      } else {
        listForStack = _ensureListForStack(
            swiper, listForStack, widget.pagination.buildv2(context, config));
      }
    }

    if (listForStack != null) {
      return new Stack(
        children: listForStack,
      );
    }

    return swiper;
  }

  Widget _buildOuterPagination(SwiperPaginationv2 pagination, Widget swiper,
      SwiperPluginConfigv2 config) {
    List<Widget> list = [];
    //Only support bottom yet!
    if (widget.containerHeight != null || widget.containerWidth != null) {
      list.add(swiper);
    } else {
      list.add(new Expanded(child: swiper));
    }

    list.add(new Align(
      alignment: Alignment.center,
      child: pagination.buildv2(context, config),
    ));

    return new Column(
      children: list,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
    );
  }
}

abstract class _SubSwiper extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final int index;
  final ValueChanged<int> onIndexChanged;
  final SwiperControllerV2 controller;
  final int duration;
  final Curve curve;
  final double itemWidth;
  final double itemHeight;
  final bool loop;
  final Axis scrollDirection;

  _SubSwiper(
      {Key key,
      this.loop,
      this.itemHeight,
      this.itemWidth,
      this.duration,
      this.curve,
      this.itemBuilder,
      this.controller,
      this.index,
      this.itemCount,
      this.scrollDirection: Axis.horizontal,
      this.onIndexChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState();

  int getCorrectIndex(int indexNeedsFix) {
    if (itemCount == 0) return 0;
    int value = indexNeedsFix % itemCount;
    if (value < 0) {
      value += itemCount;
    }
    return value;
  }
}

class _TinderSwiperV2 extends _SubSwiper {
  _TinderSwiperV2({
    Key key,
    Curve curve,
    int duration,
    SwiperControllerV2 controller,
    ValueChanged<int> onIndexChanged,
    double itemHeight,
    double itemWidth,
    IndexedWidgetBuilder itemBuilder,
    int index,
    bool loop,
    int itemCount,
    Axis scrollDirection,
  })  : assert(itemWidth != null && itemHeight != null),
        super(
            loop: loop,
            key: key,
            itemWidth: itemWidth,
            itemHeight: itemHeight,
            itemBuilder: itemBuilder,
            curve: curve,
            duration: duration,
            controller: controller,
            index: index,
            onIndexChanged: onIndexChanged,
            itemCount: itemCount,
            scrollDirection: scrollDirection);

  @override
  State<StatefulWidget> createState() {
    return new _TinderState();
  }
}

class _StackSwiper extends _SubSwiper {
  _StackSwiper({
    Key key,
    Curve curve,
    int duration,
    SwiperControllerV2 controller,
    ValueChanged<int> onIndexChanged,
    double itemHeight,
    double itemWidth,
    IndexedWidgetBuilder itemBuilder,
    int index,
    bool loop,
    int itemCount,
    Axis scrollDirection,
  }) : super(
            loop: loop,
            key: key,
            itemWidth: itemWidth,
            itemHeight: itemHeight,
            itemBuilder: itemBuilder,
            curve: curve,
            duration: duration,
            controller: controller,
            index: index,
            onIndexChanged: onIndexChanged,
            itemCount: itemCount,
            scrollDirection: scrollDirection);

  @override
  State<StatefulWidget> createState() {
    return new _StackViewState();
  }
}

class _TinderState extends _CustomLayoutStateBase<_TinderSwiperV2> {
  List<double> scales;
  List<double> offsetsX;
  List<double> offsetsY;
  List<double> opacity;
  List<double> rotates;

  double getOffsetY(double scale) {
    return widget.itemHeight - widget.itemHeight * scale;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(_TinderSwiperV2 oldWidget) {
    _updateValues();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void afterRender() {
    super.afterRender();

    _startIndex = 0;
    _animationCount = 5;
    opacity = [0.0, 0.9, 0.9, 1.0, 0.0, 0.0];
    scales = [0.5, 1.8, 1.8, 2.5, 1.5, 1.5, 1.0];
    rotates = [0.0, 0.0, 0.0, 0.0, 20.0, 25.0];
    _updateValues();
  }

  void _updateValues() {
    if (widget.scrollDirection == Axis.horizontal) {
      offsetsX = [0.0, 0.0, 0.0, 0.0, _swiperWidth, _swiperWidth];
      offsetsY = [
        0.0,
        0.0,
        -10.0,
        -15.0,
        -20.0,
      ];
    } else {
      offsetsX = [
        0.0,
        0.0,
        10.0,
        15.0,
        20.0,
      ];

      offsetsY = [0.0, 0.0, 0.0, 0.0, _swiperHeight, _swiperHeight];
    }
  }

  @override
  Widget _buildItem(int i, int realIndex, double animationValue) {
    double s = _getValue(scales, animationValue, i);
    double f = _getValue(offsetsX, animationValue, i);
    double fy = _getValue(offsetsY, animationValue, i);
    double o = _getValue(opacity, animationValue, i);
    double a = _getValue(rotates, animationValue, i);

    Alignment alignment = widget.scrollDirection == Axis.horizontal
        ? Alignment.bottomCenter
        : Alignment.centerLeft;

    return new Opacity(
      opacity: o,
      child: new Transform.rotate(
        angle: a / 180.0,
        child: new Transform.translate(
          key: new ValueKey<int>(_currentIndex + i),
          offset: new Offset(f, fy),
          child: new Transform.scale(
            scale: s,
            alignment: alignment,
            child: new SizedBox(
              width: widget.itemWidth ?? double.infinity,
              height: widget.itemHeight ?? double.infinity,
              child: widget.itemBuilder(context, realIndex),
            ),
          ),
        ),
      ),
    );
  }
}

class _StackViewState extends _CustomLayoutStateBase<_StackSwiper> {
  List<double> scales;
  List<double> offsets;
  List<double> opacity;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _updateValues() {
    if (widget.scrollDirection == Axis.horizontal) {
      double space = (_swiperWidth - widget.itemWidth) / 2;
      offsets = [-space / 3 * 8, -space / 6, 6.0, _swiperWidth];
    } else {
      double space = (_swiperHeight - widget.itemHeight) / 2;
      offsets = [-space / 3 * 8, -space / 6, 6.0, _swiperHeight];
    }
  }

  @override
  void didUpdateWidget(_StackSwiper oldWidget) {
    _updateValues();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void afterRender() {
    super.afterRender();

    //length of the values array below
    _animationCount = 4;

    //Array below this line, '0' index is 1.0 ,witch is the first item show in swiper.
    _startIndex = -1;
    scales = [0.7, 0.85, 1.0, 1.0, 1.0];
    opacity = [0.0, 1.0, 1.0, 1.0, 1.0];

    _updateValues();
  }

  @override
  Widget _buildItem(int i, int realIndex, double animationValue) {
    double s = _getValue(scales, animationValue, i);
    double f = _getValue(offsets, animationValue, i);
    double o = _getValue(opacity, animationValue, i);

    Offset offset = widget.scrollDirection == Axis.horizontal
        ? new Offset(f, 0.0)
        : new Offset(0.0, f);

    Alignment alignment = widget.scrollDirection == Axis.horizontal
        ? Alignment.centerLeft
        : Alignment.topCenter;

    return new Opacity(
      opacity: o,
      child: new Transform.translate(
        key: new ValueKey<int>(_currentIndex + i),
        offset: offset,
        child: new Transform.scale(
          scale: s,
          alignment: alignment,
          child: new SizedBox(
            width: widget.itemWidth ?? double.infinity,
            height: widget.itemHeight ?? double.infinity,
            child: widget.itemBuilder(context, realIndex),
          ),
        ),
      ),
    );
  }
}

class ScaleAndFadeTransformer extends PageTransformer {
  final double _scale;
  final double _fade;

  ScaleAndFadeTransformer({double fade: 0.3, double scale: 0.75})
      : _fade = fade,
        _scale = scale;

  @override
  Widget transform(Widget item, TransformInfo info) {
    double position = info.position;
    Widget child = item;
    if (_scale != null) {
      double scaleFactor = (1 - position.abs()) * (1 - _scale);
      double scale = _scale + scaleFactor;

      child = new Transform.scale(
        scale: scale,
        child: item,
      );
    }

    if (_fade != null) {
      double fadeFactor = (1 - position.abs()) * (1 - _fade);
      double opacity = _fade + fadeFactor;
      child = new Opacity(
        opacity: opacity,
        child: child,
      );
    }

    return child;
  }
}

abstract class SwiperPluginv2 {
  const SwiperPluginv2();

  Widget buildv2(BuildContext context, SwiperPluginConfigv2 config);
}

class SwiperPluginConfigv2 {
  final int activeIndex;
  final int itemCount;
  final PageIndicatorLayout indicatorLayout;
  final Axis scrollDirection;
  final bool loop;
  final bool outer;
  final PageController pageController;
  final SwiperControllerV2 controller;
  final SwiperLayoutV2 layout;

  const SwiperPluginConfigv2(
      {this.activeIndex,
      this.itemCount,
      this.indicatorLayout,
      this.outer,
      this.scrollDirection,
      this.controller,
      this.pageController,
      this.layout,
      this.loop})
      : assert(scrollDirection != null),
        assert(controller != null);
}

class SwiperPluginViewv2 extends StatelessWidget {
  final SwiperPluginv2 plugin;
  final SwiperPluginConfigv2 config;

  const SwiperPluginViewv2(this.plugin, this.config);

  @override
  Widget build(BuildContext context) {
    return plugin.buildv2(context, config);
  }
}

class FractionPaginationBuilderv2 extends SwiperPluginv2 {
  ///color ,if set null , will be Theme.of(context).scaffoldBackgroundColor
  final Color color;

  ///color when active,if set null , will be Theme.of(context).primaryColor
  final Color activeColor;

  ////font size
  final double fontSize;

  ///font size when active
  final double activeFontSize;

  final Key key;

  const FractionPaginationBuilderv2(
      {this.color,
      this.fontSize: 20.0,
      this.key,
      this.activeColor,
      this.activeFontSize: 35.0});

  @override
  Widget buildv2(BuildContext context, SwiperPluginConfigv2 config) {
    ThemeData themeData = Theme.of(context);
    Color activeColor = this.activeColor ?? themeData.primaryColor;
    Color color = this.color ?? themeData.scaffoldBackgroundColor;

    if (Axis.vertical == config.scrollDirection) {
      return new Column(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            "${config.activeIndex + 1}",
            style: TextStyle(color: activeColor, fontSize: activeFontSize),
          ),
          new Text(
            "/",
            style: TextStyle(color: color, fontSize: fontSize),
          ),
          new Text(
            "${config.itemCount}",
            style: TextStyle(color: color, fontSize: fontSize),
          )
        ],
      );
    } else {
      return new Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            "${config.activeIndex + 1}",
            style: TextStyle(color: activeColor, fontSize: activeFontSize),
          ),
          new Text(
            " / ${config.itemCount}",
            style: TextStyle(color: color, fontSize: fontSize),
          )
        ],
      );
    }
  }
}

class RectSwiperPaginationBuilderv2 extends SwiperPluginv2 {
  ///color when current index,if set null , will be Theme.of(context).primaryColor
  final Color activeColor;

  ///,if set null , will be Theme.of(context).scaffoldBackgroundColor
  final Color color;

  ///Size of the rect when activate
  final Size activeSize;

  ///Size of the rect
  final Size size;

  /// Space between rects
  final double space;

  final Key key;

  const RectSwiperPaginationBuilderv2(
      {this.activeColor,
      this.color,
      this.key,
      this.size: const Size(10.0, 2.0),
      this.activeSize: const Size(10.0, 2.0),
      this.space: 2.0});

  @override
  Widget buildv2(BuildContext context, SwiperPluginConfigv2 config) {
    ThemeData themeData = Theme.of(context);
    Color activeColor = this.activeColor ?? themeData.primaryColor;
    Color color = this.color ?? themeData.scaffoldBackgroundColor;

    List<Widget> list = [];

    if (config.itemCount > 20) {
      print(
          "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
    }

    int itemCount = config.itemCount;
    int activeIndex = config.activeIndex;

    for (int i = 0; i < itemCount; ++i) {
      bool active = i == activeIndex;
      Size size = active ? this.activeSize : this.size;
      list.add(SizedBox(
        width: size.width,
        height: size.height,
        child: Container(
          color: active ? activeColor : color,
          key: Key("pagination_$i"),
          margin: EdgeInsets.all(space),
        ),
      ));
    }

    if (config.scrollDirection == Axis.vertical) {
      return new Column(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    } else {
      return new Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    }
  }
}

class DotSwiperPaginationBuilderv2 extends SwiperPluginv2 {
  ///color when current index,if set null , will be Theme.of(context).primaryColor
  final Color activeColor;

  ///,if set null , will be Theme.of(context).scaffoldBackgroundColor
  final Color color;

  ///Size of the dot when activate
  final double activeSize;

  ///Size of the dot
  final double size;

  /// Space between dots
  final double space;

  final Key key;

  const DotSwiperPaginationBuilderv2(
      {this.activeColor,
      this.color,
      this.key,
      this.size: 10.0,
      this.activeSize: 10.0,
      this.space: 10.0});

  @override
  Widget buildv2(BuildContext context, SwiperPluginConfigv2 config) {
    if (config.itemCount > 20) {
      print(
          "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
    }
    Color activeColor = this.activeColor;
    Color color = this.color;

    if (activeColor == null || color == null) {
      ThemeData themeData = Theme.of(context);
      activeColor = this.activeColor ?? themeData.primaryColor;
      color = this.color ?? themeData.scaffoldBackgroundColor;
    }

    if (config.indicatorLayout != PageIndicatorLayout.NONE &&
        config.layout == SwiperLayout.DEFAULT) {
      return new PageIndicator(
        count: config.itemCount,
        controller: config.pageController,
        layout: config.indicatorLayout,
        size: size,
        activeColor: activeColor,
        color: color,
        space: space,
      );
    }

    List<Widget> list = [];

    int itemCount = config.itemCount;
    int activeIndex = config.activeIndex;

    for (int i = 0; i < itemCount; ++i) {
      bool active = i == activeIndex;
      list.add(Container(
        key: Key("pagination_$i"),
        margin: EdgeInsets.all(space),
        child: ClipOval(
          child: Container(
            color: active ? activeColor : color,
            width: active ? activeSize : size,
            height: active ? activeSize : size,
          ),
        ),
      ));
    }

    if (config.scrollDirection == Axis.vertical) {
      return new Column(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    } else {
      return new Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    }
  }
}

typedef Widget SwiperPaginationBuilderv2(
    BuildContext context, SwiperPluginConfigv2 config);

class SwiperCustomPaginationv2 extends SwiperPluginv2 {
  final SwiperPaginationBuilderv2 builder;

  SwiperCustomPaginationv2({@required this.builder}) : assert(builder != null);

  @override
  Widget buildv2(BuildContext context, SwiperPluginConfigv2 config) {
    // TODO: implement buildv2
    return builder(context, config);
  }
}

class SwiperPaginationv2 extends SwiperPluginv2 {
  /// dot style pagination
  static const SwiperPluginv2 dots = const DotSwiperPaginationBuilderv2();

  /// fraction style pagination
  static const SwiperPlugin fraction = const FractionPaginationBuilder();

  static const SwiperPluginv2 rect = const RectSwiperPaginationBuilderv2();

  /// Alignment.bottomCenter by default when scrollDirection== Axis.horizontal
  /// Alignment.centerRight by default when scrollDirection== Axis.vertical
  final Alignment alignment;

  /// Distance between pagination and the container
  final EdgeInsetsGeometry margin;

  /// Build the widet
  final SwiperPluginv2 builder;

  final Key key;

  const SwiperPaginationv2(
      {this.alignment,
      this.key,
      this.margin: const EdgeInsets.all(10.0),
      this.builder: SwiperPaginationv2.dots});

  Widget buildv2(BuildContext context, SwiperPluginConfigv2 config) {
    Alignment alignment = this.alignment ??
        (config.scrollDirection == Axis.horizontal
            ? Alignment.bottomCenter
            : Alignment.centerRight);
    Widget child = Container(
      margin: margin,
      child: this.builder.buildv2(context, config),
    );
    if (!config.outer) {
      child = new Align(
        key: key,
        alignment: alignment,
        child: child,
      );
    }
    return child;
  }
}

class SwiperControllerV2 extends IndexController {
  // Autoplay is started
  static const int START_AUTOPLAY = 2;

  // Autoplay is stopped.
  static const int STOP_AUTOPLAY = 2;

  // Indicate that the user is swiping
  static const int SWIPE = 3;

  // Indicate that the `Swiper` has changed it's index and is building it's ui ,so that the
  // `SwiperPluginConfig` is available.
  static const int BUILD = 2;

  // available when `event` == SwiperController.BUILD
  SwiperPluginConfigv2 config;

  // available when `event` == SwiperController.SWIPE
  // this value is PageViewController.pos
  double pos;

  int index;
  bool animation;
  bool autoplay;

  SwiperControllerV2();

  void startAutoplay() {
    event = SwiperControllerV2.START_AUTOPLAY;
    this.autoplay = true;
    notifyListeners();
  }

  void stopAutoplay() {
    event = SwiperControllerV2.STOP_AUTOPLAY;
    this.autoplay = false;
    notifyListeners();
  }
}
