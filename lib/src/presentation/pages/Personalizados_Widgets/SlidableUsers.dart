import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/src/widgets/slidable.dart';
import 'package:woin/src/entities/users/userTransactions.dart';
import 'package:woin/src/services/usuario/blocUserTransactions.dart';

const bool _kCloseOnTap = true;

/// Abstract class for slide actions that can close after [onTap] occurred.
abstract class ClosableSlideAction extends StatelessWidget {
  /// Creates a slide that closes when a tap has occurred if [closeOnTap]
  /// is [true].
  ///
  /// The [closeOnTap] argument must not be null.
  const ClosableSlideAction({
    Key key,
    this.color,
    this.onTap,
    this.closeOnTap = _kCloseOnTap,
  })  : assert(closeOnTap != null),
        super(key: key);

  /// The background color of this action.
  final Color color;

  /// A tap has occurred.
  final VoidCallback onTap;

  /// Whether close this after tap occurred.
  ///
  /// Defaults to true.
  final bool closeOnTap;

  /// Calls [onTap] if not null and closes the closest [Slidable]
  /// that encloses the given context.
  void _handleCloseAfterTap(BuildContext context) {
    onTap?.call();
    Slidable.of(context)?.close();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
        color: color,
        child: InkWell(
          onTap: !closeOnTap ? onTap : () => _handleCloseAfterTap(context),
          child: buildAction(context),
        ),
      ),
    );
  }

  /// Builds the action.
  @protected
  Widget buildAction(BuildContext context);
}

/// A basic slide action with a background color and a child that will
/// be center inside its area.
class SlideAction extends ClosableSlideAction {
  /// Creates a slide action with a child.
  ///
  /// The `color` argument is a shorthand for `decoration:
  /// BoxDecoration(color: color)`, which means you cannot supply both a `color`
  /// and a `decoration` argument. If you want to have both a `color` and a
  /// `decoration`, you can pass the color as the `color` argument to the
  /// `BoxDecoration`.
  ///
  /// The [closeOnTap] argument must not be null.
  SlideAction({
    Key key,
    @required this.child,
    VoidCallback onTap,
    Color color,
    Decoration decoration,
    bool closeOnTap = _kCloseOnTap,
  })  : assert(child != null),
        assert(decoration == null || decoration.debugAssertIsValid()),
        assert(
            color == null || decoration == null,
            'Cannot provide both a color and a decoration\n'
            'The color argument is just a shorthand for "decoration:  BoxDecoration(color: color)".'),
        decoration =
            decoration ?? (color != null ? BoxDecoration(color: color) : null),
        super(
          key: key,
          onTap: onTap,
          closeOnTap: closeOnTap,
          color: color ?? Colors.transparent,
        );

  /// The decoration to paint behind the [child].
  ///
  /// A shorthand for specifying just a solid color is available in the
  /// constructor: set the `color` argument instead of the `decoration`
  /// argument.
  final Decoration decoration;

  /// The [child] contained by the slide action.
  final Widget child;

  @override
  Widget buildAction(BuildContext context) {
    return Container(
      decoration: decoration,
      child: Center(
        child: child,
      ),
    );
  }
}

/// A basic slide action with an icon, a caption and a background color.
class IconSlideAction extends ClosableSlideAction {
  /// Creates a slide action with an icon, a [caption] if set and a
  /// background color.
  ///
  /// The [closeOnTap] argument must not be null.
  const IconSlideAction({
    Key key,
    this.icon,
    this.iconWidget,
    this.caption,
    Color color,
    this.foregroundColor,
    VoidCallback onTap,
    bool closeOnTap = _kCloseOnTap,
  })  : color = color ?? Colors.white,
        assert(icon != null || iconWidget != null,
            'Either set icon or iconWidget.'),
        super(
          key: key,
          color: color,
          onTap: onTap,
          closeOnTap: closeOnTap,
        );

  /// The icon to show.
  final IconData icon;

  /// A custom widget to represent the icon.
  /// If both [icon] and [iconWidget] are set, they will be shown at the same
  /// time.
  final Widget iconWidget;

  /// The caption below the icon.
  final String caption;

  /// The background color.
  ///
  /// Defaults to [Colors.white].
  final Color color;

  /// The color used for [icon] and [caption].
  final Color foregroundColor;

  @override
  Widget buildAction(BuildContext context) {
    final Color estimatedColor =
        ThemeData.estimateBrightnessForColor(color) == Brightness.light
            ? Colors.black
            : Colors.white;

    final List<Widget> widgets = [];

    if (icon != null) {
      widgets.add(
        Flexible(
          child: new Icon(
            icon,
            color: foregroundColor ?? estimatedColor,
          ),
        ),
      );
    }

    if (iconWidget != null) {
      widgets.add(
        Flexible(child: iconWidget),
      );
    }

    if (caption != null) {
      widgets.add(
        Flexible(
          child: Text(
            caption,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .primaryTextTheme
                .caption
                .copyWith(color: foregroundColor ?? estimatedColor),
          ),
        ),
      );
    }

    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widgets,
        ),
      ),
    );
  }
}

class _SlidableStackActionPane extends StatelessWidget {
  _SlidableStackActionPane({
    Key key,
    @required this.data,
    @required this.child,
  })  : _animation = Tween<Offset>(
          begin: Offset.zero,
          end: data.createOffset(data.totalActionsExtent * data.actionSign),
        ).animate(data.actionsMoveAnimation),
        super(key: key);

  final Widget child;
  final SlidableData data;
  final Animation<Offset> _animation;

  @override
  Widget build(BuildContext context) {
    if (data.actionsMoveAnimation.isDismissed) {
      return data.slidable.child;
    }

    return Stack(
      children: <Widget>[
        child,
        SlideTransition(
          position: _animation,
          child: data.slidable.child,
        ),
      ],
    );
  }
}

/// An action pane that creates actions which stretch while the item is sliding.
class SlidableStrechActionPane extends StatelessWidget {
  const SlidableStrechActionPane({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SlidableData data = SlidableData.of(context);

    final animation = Tween<double>(
      begin: 0.0,
      end: data.totalActionsExtent,
    ).animate(data.actionsMoveAnimation);

    return _SlidableStackActionPane(
      data: data,
      child: Positioned.fill(
        child: AnimatedBuilder(
          animation: data.actionsMoveAnimation,
          builder: (context, child) {
            return FractionallySizedBox(
              alignment: data.alignment,
              widthFactor: data.directionIsXAxis ? animation.value : null,
              heightFactor: data.directionIsXAxis ? null : animation.value,
              child: Flex(
                direction: data.direction,
                children: data
                    .buildActions(context)
                    .map((a) => Expanded(child: a))
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// An action pane that creates actions which stay behind the item while it's sliding.
class SlidableBehindActionPane extends StatelessWidget {
  const SlidableBehindActionPane({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SlidableData data = SlidableData.of(context);

    return _SlidableStackActionPane(
      data: data,
      child: Positioned.fill(
        child: FractionallySizedBox(
          alignment: data.alignment,
          widthFactor: data.actionPaneWidthFactor,
          heightFactor: data.actionPaneHeightFactor,
          child: Flex(
            direction: data.direction,
            children: data
                .buildActions(context)
                .map((a) => Expanded(child: a))
                .toList(),
          ),
        ),
      ),
    );
  }
}

/// An action pane that creates actions which follow the item while it's sliding.
class SlidableScrollActionPane extends StatelessWidget {
  /// Creates an action pane that creates actions which follow the item while it's sliding.
  const SlidableScrollActionPane({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SlidableData data = SlidableData.of(context);

    final alignment = data.alignment;
    final animation = Tween<Offset>(
      begin: Offset(alignment.x, alignment.y),
      end: Offset.zero,
    ).animate(data.actionsMoveAnimation);

    return _SlidableStackActionPane(
      data: data,
      child: Positioned.fill(
        child: FractionallySizedBox(
          alignment: data.alignment,
          widthFactor: data.actionPaneWidthFactor,
          heightFactor: data.actionPaneHeightFactor,
          child: SlideTransition(
            position: animation,
            child: Flex(
              direction: data.direction,
              children: data
                  .buildActions(context)
                  .map((a) => Expanded(child: a))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

/// An action pane that creates actions which animate like drawers while the item is sliding.
class SlidableDrawerActionPane extends StatelessWidget {
  /// Creates an action pane that creates actions which animate like drawers while the item is sliding.
  const SlidableDrawerActionPane({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SlidableData data = SlidableData.of(context);

    final alignment = data.alignment;
    final startOffset = Offset(alignment.x, alignment.y);
    final animations = Iterable.generate(data.actionCount).map((index) {
      return Tween<Offset>(
        begin: startOffset,
        end: startOffset * (index - data.actionCount + 1.0),
      ).animate(data.actionsMoveAnimation);
    }).toList();

    return _SlidableStackActionPane(
      data: data,
      child: Positioned.fill(
        child: Stack(
          alignment: data.alignment,
          children: List.generate(
            data.actionCount,
            (index) {
              int displayIndex =
                  data.showActions ? data.actionCount - index - 1 : index;
              return SlideTransition(
                position: animations[index],
                child: FractionallySizedBox(
                  alignment: data.alignment,
                  widthFactor:
                      data.directionIsXAxis ? data.actionExtentRatio : null,
                  heightFactor:
                      data.directionIsXAxis ? null : data.actionExtentRatio,
                  child: data.actionDelegate.build(
                    context,
                    displayIndex,
                    data.actionsMoveAnimation,
                    SlidableRenderingMode.slide,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

const Duration _kResizeDuration = const Duration(milliseconds: 300);

/// A widget that controls how the [Slidable] is dismissed.
///
/// The [Slidable] widget calls the [onDismissed] callback either after its size has
/// collapsed to zero (if [resizeDuration] is non-null) or immediately after
/// the slide animation (if [resizeDuration] is null). If the [Slidable] is a
/// list item, it must have a key that distinguishes it from the other items and
/// its [onDismissed] callback must remove the item from the list.
///
/// See also:
///
///  * [SlidableDrawerDismissal], which creates slide actions that are displayed like drawers
///  while the item is dismissing.
class SlidableDismissal extends StatelessWidget {
  /// Creates a widget that controls how the [Slidable] is dismissed.
  const SlidableDismissal({
    @required this.child,
    this.dismissThresholds = const <SlideActionType, double>{},
    this.onResize,
    this.onDismissed,
    this.resizeDuration = _kResizeDuration,
    this.crossAxisEndOffset = 0.0,
    this.onWillDismiss,
    this.closeOnCanceled = false,
    this.dragDismissible = true,
  }) : assert(dismissThresholds != null);

  /// Specifies if the widget can be dismissed by sliding.
  ///
  /// Setting to false makes the widget dismissible only by
  /// calling [Slidable.dismiss()].
  ///
  /// Defaults to true.
  final bool dragDismissible;

  /// The offset threshold the item has to be dragged in order to be considered
  /// dismissed.
  ///
  /// Represented as a fraction, e.g. if it is 0.4 (the default), then the item
  /// has to be dragged at least 40% towards one direction to be considered
  /// dismissed. Clients can define different thresholds for each dismiss
  /// direction.
  ///
  /// Flinging is treated as being equivalent to dragging almost to 1.0, so
  /// flinging can dismiss an item past any threshold less than 1.0.
  ///
  /// Setting a threshold of 1.0 (or greater) prevents a drag for
  //  the given [SlideActionType]
  final Map<SlideActionType, double> dismissThresholds;

  /// Called when the widget has been dismissed, after finishing resizing.
  final DismissSlideActionCallback onDismissed;

  /// Called before the widget is dismissed. If the call returns false, the
  /// item will not be dismissed.
  ///
  /// If null, the widget will always be dismissed.
  final SlideActionWillBeDismissed onWillDismiss;

  /// Specifies to close this slidable after canceling dismiss.
  ///
  /// Defaults to false.
  final bool closeOnCanceled;

  /// Called when the widget changes size (i.e., when contracting before being dismissed).
  final VoidCallback onResize;

  /// The amount of time the widget will spend contracting before [onDismissed] is called.
  ///
  /// If null, the widget will not contract and [onDismissed] will be called
  /// immediately after the widget is dismissed.
  final Duration resizeDuration;

  /// Defines the end offset across the main axis after the card is dismissed.
  ///
  /// If non-zero value is given then widget moves in cross direction depending on whether
  /// it is positive or negative.
  final double crossAxisEndOffset;

  /// The widget to show when the [Slidable] enters dismiss mode.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final SlidableData data = SlidableData.of(context);

    return AnimatedBuilder(
      animation: data.overallMoveAnimation,
      child: child,
      builder: (BuildContext context, Widget child) {
        if (data.overallMoveAnimation.value > data.totalActionsExtent) {
          return child;
        } else {
          return data.slidable.actionPane;
        }
      },
    );
  }
}

/// A specific dismissal that creates slide actions that are displayed like drawers
/// while the item is dismissing.
/// The further slide action will grow faster than the other ones.
class SlidableDrawerDismissal extends StatelessWidget {
  /// Creates a specific dismissal that creates slide actions that are displayed like drawers
  /// while the item is dismissing.
  const SlidableDrawerDismissal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SlidableData data = SlidableData.of(context);

    final animation = Tween<Offset>(
      begin: Offset.zero,
      end: data.createOffset(data.actionSign),
    ).animate(data.overallMoveAnimation);

    final count = data.actionCount;

    final extentAnimations = Iterable.generate(count).map((index) {
      return Tween<double>(
        begin: data.actionExtentRatio,
        end: 1 - data.actionExtentRatio * (data.actionCount - index - 1),
      ).animate(
        CurvedAnimation(
          parent: data.overallMoveAnimation,
          curve: Interval(data.totalActionsExtent, 1.0),
        ),
      );
    }).toList();

    return Stack(
      children: <Widget>[
        AnimatedBuilder(
            animation: data.overallMoveAnimation,
            builder: (context, child) {
              return Positioned.fill(
                child: Stack(
                  children: List.generate(data.actionCount, (index) {
                    // For the main actions we have to reverse the order if we want the last item at the bottom of the stack.
                    int displayIndex =
                        data.showActions ? data.actionCount - index - 1 : index;

                    return data.createFractionallyAlignedSizedBox(
                      positionFactor: data.actionExtentRatio *
                          (data.actionCount - index - 1),
                      extentFactor: extentAnimations[index].value,
                      child: data.actionDelegate.build(context, displayIndex,
                          data.actionsMoveAnimation, data.renderingMode),
                    );
                  }),
                ),
              );
            }),
        SlideTransition(
          position: animation,
          child: data.slidable.child,
        ),
      ],
    );
  }
}

/// A widget that positions its child to a fraction of the total available space.
class FractionallyAlignedSizedBox extends StatelessWidget {
  /// Creates a widget that positions its child to a fraction of the total available space.
  ///
  /// Only two out of the three horizontal values ([leftFactor], [rightFactor],
  /// [widthFactor]), and only two out of the three vertical values ([topFactor],
  /// [bottomFactor], [heightFactor]), can be set. In each case, at least one of
  /// the three must be null.
  ///
  /// If non-null, the [widthFactor] and [heightFactor] arguments must be
  /// non-negative.
  FractionallyAlignedSizedBox({
    Key key,
    @required this.child,
    this.leftFactor,
    this.topFactor,
    this.rightFactor,
    this.bottomFactor,
    this.widthFactor,
    this.heightFactor,
  })  : assert(
            leftFactor == null || rightFactor == null || widthFactor == null),
        assert(
            topFactor == null || bottomFactor == null || heightFactor == null),
        assert(widthFactor == null || widthFactor >= 0.0),
        assert(heightFactor == null || heightFactor >= 0.0),
        super(key: key);

  /// The relative distance that the child's left edge is inset from the left of the parent.
  final double leftFactor;

  /// The relative distance that the child's top edge is inset from the top of the parent.
  final double topFactor;

  /// The relative distance that the child's right edge is inset from the right of the parent.
  final double rightFactor;

  /// The relative distance that the child's bottom edge is inset from the bottom of the parent.
  final double bottomFactor;

  /// The child's width relative to its parent's width.
  final double widthFactor;

  /// The child's height relative to its parent's height.
  final double heightFactor;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    double dx = 0;
    double dy = 0;
    double width = widthFactor;
    double height = heightFactor;

    if (widthFactor == null) {
      final left = leftFactor ?? 0;
      final right = rightFactor ?? 0;
      width = 1 - left - right;

      if (width != 1) {
        dx = left / (1.0 - width);
      }
    }

    if (heightFactor == null) {
      final top = topFactor ?? 0;
      final bottom = bottomFactor ?? 0;
      height = 1 - top - bottom;
      if (height != 1) {
        dy = top / (1.0 - height);
      }
    }

    if (widthFactor != null && widthFactor != 1) {
      if (leftFactor != null) {
        dx = leftFactor / (1 - widthFactor);
      } else if (leftFactor == null && rightFactor != null) {
        dx = (1 - widthFactor - rightFactor) / (1 - widthFactor);
      }
    }

    if (heightFactor != null && heightFactor != 1) {
      if (topFactor != null) {
        dy = topFactor / (1 - heightFactor);
      } else if (topFactor == null && bottomFactor != null) {
        dy = (1 - heightFactor - bottomFactor) / (1 - heightFactor);
      }
    }

    return Align(
      alignment: FractionalOffset(
        dx,
        dy,
      ),
      child: FractionallySizedBox(
        widthFactor: width,
        heightFactor: height,
        child: child,
      ),
    );
  }
}

//DEPENDENCIAS NECESARIAS

const double _kActionsExtentRatio = 0.25;
const double _kFastThreshold = 2500.0;
const double _kDismissThreshold = 0.75;
const Curve _kResizeTimeCurve = const Interval(0.4, 1.0, curve: Curves.ease);
const Duration _kMovementDuration = const Duration(milliseconds: 200);

/// The rendering mode in which the [Slidable] is.
enum SlidableRenderingMode {
  /// The [Slidable] is not showing actions.
  none,

  /// The [Slidable] is showing actions during sliding.
  slide,

  /// The [Slidable] is showing actions during dismissing.
  dismiss,

  /// The [Slidable] is resizing after dismissing.
  resize,
}

/// The type of slide action that is currently been showed by the [Slidable].
enum SlideActionType {
  /// The [actions] are being shown.
  primary,

  /// The [secondaryActions] are being shown.
  secondary,
}

/// Signature used by [SlideToDismissDelegate] to indicate that it has been
/// dismissed for the given [actionType].
///
/// Used by [SlideToDismissDelegate.onDismissed].
typedef void DismissSlideActionCallback(SlideActionType actionType);

/// Signature for determining whether the widget will be dismissed for the
/// given [actionType].
///
/// Used by [SlideToDismissDelegate.onWillDismiss].
typedef FutureOr<bool> SlideActionWillBeDismissed(SlideActionType actionType);

/// Signature for the builder callback used to create slide actions.
typedef Widget SlideActionBuilder(BuildContext context, int index,
    Animation<double> animation, SlidableRenderingMode step);

/// A delegate that supplies slide actions.
///
/// It's uncommon to subclass [SlideActionDelegate]. Instead, consider using one
/// of the existing subclasses that provide adaptors to builder callbacks or
/// explicit action lists.
///
/// See also:
///
///  * [SlideActionBuilderDelegate], which is a delegate that uses a builder
///    callback to construct the slide actions.
///  * [SlideActionListDelegate], which is a delegate that has an explicit list
///    of slidable action.
abstract class SlideActionDelegate {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const SlideActionDelegate();

  /// Returns the child with the given index.
  ///
  /// Must not return null.
  Widget build(BuildContext context, int index, Animation<double> animation,
      SlidableRenderingMode step);

  /// Returns the number of actions this delegate will build.
  int get actionCount;
}

/// A delegate that supplies slide actions using a builder callback.
///
/// This delegate provides slide actions using a [SlideActionBuilder] callback,
/// so that the animation can be passed down to the final widget.
///
/// See also:
///
///  * [SlideActionListDelegate], which is a delegate that has an explicit list
///    of slide action.
class SlideActionBuilderDelegate extends SlideActionDelegate {
  /// Creates a delegate that supplies slide actions using the given
  /// builder callback.
  ///
  /// The [builder] must not be null. The [actionCount] argument must not be positive.
  const SlideActionBuilderDelegate({
    @required this.builder,
    @required this.actionCount,
  }) : assert(actionCount != null && actionCount >= 0);

  /// Called to build slide actions.
  ///
  /// Will be called only for indices greater than or equal to zero and less
  /// than [childCount].
  final SlideActionBuilder builder;

  /// The total number of slide actions this delegate can provide.
  final int actionCount;

  @override
  Widget build(BuildContext context, int index, Animation<double> animation,
          SlidableRenderingMode step) =>
      builder(context, index, animation, step);
}

/// A delegate that supplies slide actions using an explicit list.
///
/// This delegate provides slide actions using an explicit list,
/// which is convenient but reduces the benefit of passing the animation down
/// to the final widget.
///
/// See also:
///
///  * [SlideActionBuilderDelegate], which is a delegate that uses a builder
///    callback to construct the slide actions.
class SlideActionListDelegate extends SlideActionDelegate {
  /// Creates a delegate that supplies slide actions using the given
  /// list.
  ///
  /// The [actions] argument must not be null.
  const SlideActionListDelegate({
    @required this.actions,
  });

  /// The slide actions.
  final List<Widget> actions;

  /// The number of actions.
  @override
  int get actionCount => actions?.length ?? 0;

  @override
  Widget build(BuildContext context, int index, Animation<double> animation,
          SlidableRenderingMode step) =>
      actions[index];
}

class _SlidableScope extends InheritedWidget {
  _SlidableScope({
    Key key,
    @required this.state,
    @required Widget child,
  }) : super(key: key, child: child);

  final SlidableState state;

  @override
  bool updateShouldNotify(_SlidableScope oldWidget) => oldWidget.state != state;
}

/// The data used by a [Slidable].
class SlidableData extends InheritedWidget {
  SlidableData({
    Key key,
    @required this.actionType,
    @required this.renderingMode,
    @required this.totalActionsExtent,
    @required this.dismissThreshold,
    @required this.dismissible,
    @required this.actionDelegate,
    @required this.overallMoveAnimation,
    @required this.actionsMoveAnimation,
    @required this.dismissAnimation,
    @required this.slidable,
    @required this.actionExtentRatio,
    @required this.direction,
    @required Widget child,
  }) : super(key: key, child: child);

  /// The type of slide action that is currently been showed by the [Slidable].
  final SlideActionType actionType;

  /// The rendering mode in which the [Slidable] is.
  final SlidableRenderingMode renderingMode;

  /// The total extent of all the actions
  final double totalActionsExtent;

  /// The offset threshold the item has to be dragged in order to be considered
  /// dismissed.
  final double dismissThreshold;

  /// Indicates whether the [Slidable] can be dismissed.
  final bool dismissible;

  /// The current actions that have to be shown.
  final SlideActionDelegate actionDelegate;

  /// Animation for the whole movement.
  final Animation<double> overallMoveAnimation;

  /// Animation for the actions.
  final Animation<double> actionsMoveAnimation;

  /// Dismiss animation.
  final Animation<double> dismissAnimation;

  /// The slidable.
  final SlidableV2 slidable;

  /// Relative ratio between one slide action and the extent of the child.
  final double actionExtentRatio;

  /// The direction in which this widget can be slid.
  final Axis direction;

  /// Indicates whether the primary actions are currently shown.
  bool get showActions => actionType == SlideActionType.primary;

  /// The number of actions.
  int get actionCount => actionDelegate?.actionCount ?? 0;

  /// If the [actionType] is [SlideActionType.primary] returns 1, -1 otherwise.
  double get actionSign => actionType == SlideActionType.primary ? 1.0 : -1.0;

  /// Indicates wheter the direction is horizontal.
  bool get directionIsXAxis => direction == Axis.horizontal;

  /// The alignment of the actions.
  Alignment get alignment => Alignment(
        directionIsXAxis ? -actionSign : 0.0,
        directionIsXAxis ? 0.0 : -actionSign,
      );

  /// If the [direction] is horizontal, returns the [totalActionsExtent]
  /// otherwise null.
  double get actionPaneWidthFactor =>
      directionIsXAxis ? totalActionsExtent : null;

  /// If the [direction] is vertical, returns the [totalActionsExtent]
  /// otherwise null.
  double get actionPaneHeightFactor =>
      directionIsXAxis ? null : totalActionsExtent;

  /// The data from the closest instance of this class that encloses the given context.
  static SlidableData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SlidableData>();
  }

  /// Gets the the given offset related to the current direction.
  Offset createOffset(double value) {
    return directionIsXAxis ? Offset(value, 0.0) : Offset(0.0, value);
  }

  /// Gets the maximum extent in the current direction.
  double getMaxExtent(BoxConstraints constraints) {
    return directionIsXAxis ? constraints.maxWidth : constraints.maxHeight;
  }

  /// Creates a positioned related to the current direction and showed actions.
  Positioned createPositioned({
    Widget child,
    double extent,
    double position,
  }) {
    return Positioned(
      left: directionIsXAxis ? (showActions ? position : null) : 0.0,
      right: directionIsXAxis ? (showActions ? null : position) : 0.0,
      top: directionIsXAxis ? 0.0 : (showActions ? position : null),
      bottom: directionIsXAxis ? 0.0 : (showActions ? null : position),
      width: directionIsXAxis ? extent : null,
      height: directionIsXAxis ? null : extent,
      child: child,
    );
  }

  /// Creates a [FractionallyAlignedSizedBox] related to the current direction and showed actions.
  FractionallyAlignedSizedBox createFractionallyAlignedSizedBox({
    Widget child,
    double extentFactor,
    double positionFactor,
  }) {
    return FractionallyAlignedSizedBox(
      leftFactor:
          directionIsXAxis ? (showActions ? positionFactor : null) : 0.0,
      rightFactor:
          directionIsXAxis ? (showActions ? null : positionFactor) : 0.0,
      topFactor: directionIsXAxis ? 0.0 : (showActions ? positionFactor : null),
      bottomFactor:
          directionIsXAxis ? 0.0 : (showActions ? null : positionFactor),
      widthFactor: directionIsXAxis ? extentFactor : null,
      heightFactor: directionIsXAxis ? null : extentFactor,
      child: child,
    );
  }

  /// Builds the slide actions using the active [SlideActionDelegate]'s builder.
  List<Widget> buildActions(BuildContext context) {
    return List.generate(
      actionCount,
      (int index) => actionDelegate.build(
        context,
        index,
        actionsMoveAnimation,
        SlidableRenderingMode.slide,
      ),
    );
  }

  /// Whether the framework should notify widgets that inherit from this widget.
  @override
  bool updateShouldNotify(SlidableData oldWidget) =>
      (oldWidget.actionType != actionType) ||
      (oldWidget.renderingMode != renderingMode) ||
      (oldWidget.totalActionsExtent != totalActionsExtent) ||
      (oldWidget.dismissThreshold != dismissThreshold) ||
      (oldWidget.dismissible != dismissible) ||
      (oldWidget.actionDelegate != actionDelegate) ||
      (oldWidget.overallMoveAnimation != overallMoveAnimation) ||
      (oldWidget.actionsMoveAnimation != actionsMoveAnimation) ||
      (oldWidget.dismissAnimation != dismissAnimation) ||
      (oldWidget.slidable != slidable) ||
      (oldWidget.actionExtentRatio != actionExtentRatio) ||
      (oldWidget.direction != direction);
}

/// A controller that keep tracks of the active [SlidableState] and close
/// the previous one.
class SlidableController {
  /// Creates a controller that keep tracks of the active [SlidableState] and close
  /// the previous one.
  SlidableController({
    this.onSlideAnimationChanged,
    this.onSlideIsOpenChanged,
  });

  /// Function called when the animation changed.
  final ValueChanged<Animation<double>> onSlideAnimationChanged;

  /// Function called when the [Slidable] open status changed.
  final ValueChanged<bool> onSlideIsOpenChanged;

  bool _isSlideOpen;

  Animation<double> _slideAnimation;

  SlidableState _activeState;

  /// The state of the active [Slidable].
  SlidableState get activeState => _activeState;

  /// Changes the state of the active [Slidable].
  set activeState(SlidableState value) {
    _activeState?._flingAnimationController();

    _activeState = value;
    if (onSlideAnimationChanged != null) {
      _slideAnimation?.removeListener(_handleSlideIsOpenChanged);
      if (onSlideIsOpenChanged != null) {
        _slideAnimation = value?.overallMoveAnimation;
        _slideAnimation?.addListener(_handleSlideIsOpenChanged);
        if (_slideAnimation == null) {
          _isSlideOpen = false;

          onSlideIsOpenChanged(_isSlideOpen);
        }
      }
      onSlideAnimationChanged(value?.overallMoveAnimation);
    }
  }

  void _handleSlideIsOpenChanged() {
    if (onSlideIsOpenChanged != null && _slideAnimation != null) {
      final bool isOpen = _slideAnimation.value != 0.0;
      if (isOpen != _isSlideOpen) {
        _isSlideOpen = isOpen;

        onSlideIsOpenChanged(_isSlideOpen);
      }
    }
  }
}

/// A widget that can be slid in both direction of the specified axis.
///
/// If the direction is [Axis.horizontal], this widget can be slid to the left or to the right,
/// otherwise this widget can be slid up or slid down.
///
/// By sliding in one of these direction, slide actions will appear.
class SlidableV2 extends StatefulWidget {
  /// Creates a widget that can be slid.
  ///
  /// The [actions] contains the slide actions that appears when the child has been dragged down or to the right.
  /// The [secondaryActions] contains the slide actions that appears when the child has been dragged up or to the left.
  ///
  /// The [delegate] and [closeOnScroll] arguments must not be null. The [actionExtentRatio]
  /// and [showAllActionsThreshold] arguments must be greater or equal than 0 and less or equal than 1.
  ///
  /// The [key] argument must not be null if the `slideToDismissDelegate`
  /// is provided because [Slidable]s are commonly
  /// used in lists and removed from the list when dismissed. Without keys, the
  /// default behavior is to sync widgets based on their index in the list,
  /// which means the item after the dismissed item would be synced with the
  /// state of the dismissed item. Using keys causes the widgets to sync
  /// according to their keys and avoids this pitfall.
  SlidableV2({
    userTransactions user,
    Key key,
    @required Widget child,
    @required Widget actionPane,
    List<Widget> actions,
    List<Widget> secondaryActions,
    double showAllActionsThreshold = 0.5,
    double actionExtentRatio = _kActionsExtentRatio,
    Duration movementDuration = _kMovementDuration,
    Axis direction = Axis.horizontal,
    bool closeOnScroll = true,
    bool enabled = true,
    SlidableDismissal dismissal,
    SlidableController controller,
    double fastThreshold,
  }) : this.builder(
          user: user,
          key: key,
          child: child,
          actionPane: actionPane,
          actionDelegate: SlideActionListDelegate(actions: actions),
          secondaryActionDelegate:
              SlideActionListDelegate(actions: secondaryActions),
          showAllActionsThreshold: showAllActionsThreshold,
          actionExtentRatio: actionExtentRatio,
          movementDuration: movementDuration,
          direction: direction,
          closeOnScroll: closeOnScroll,
          enabled: enabled,
          dismissal: dismissal,
          controller: controller,
          fastThreshold: fastThreshold,
        );

  /// Creates a widget that can be slid.
  ///
  /// The [actionDelegate] is a delegate that builds the slide actions that appears when the child has been dragged down or to the right.
  /// The [secondaryActionDelegate] is a delegate that builds the slide actions that appears when the child has been dragged up or to the left.
  ///
  /// The [delegate], [closeOnScroll] and [enabled] arguments must not be null. The [actionExtentRatio]
  /// and [showAllActionsThreshold] arguments must be greater or equal than 0 and less or equal than 1.
  ///
  /// The [key] argument must not be null if the `slideToDismissDelegate`
  /// is provided because [Slidable]s are commonly
  /// used in lists and removed from the list when dismissed. Without keys, the
  /// default behavior is to sync widgets based on their index in the list,
  /// which means the item after the dismissed item would be synced with the
  /// state of the dismissed item. Using keys causes the widgets to sync
  /// according to their keys and avoids this pitfall.
  SlidableV2.builder({
    this.user,
    Key key,
    @required this.child,
    @required this.actionPane,
    this.actionDelegate,
    this.secondaryActionDelegate,
    this.showAllActionsThreshold = 0.5,
    this.actionExtentRatio = _kActionsExtentRatio,
    this.movementDuration = _kMovementDuration,
    this.direction = Axis.horizontal,
    this.closeOnScroll = true,
    this.enabled = true,
    this.dismissal,
    this.controller,
    double fastThreshold,
  })  : assert(actionPane != null),
        assert(direction != null),
        assert(
            showAllActionsThreshold != null &&
                showAllActionsThreshold >= .0 &&
                showAllActionsThreshold <= 1.0,
            'showAllActionsThreshold must be between 0.0 and 1.0'),
        assert(
            actionExtentRatio != null &&
                actionExtentRatio >= .0 &&
                actionExtentRatio <= 1.0,
            'actionExtentRatio must be between 0.0 and 1.0'),
        assert(closeOnScroll != null),
        assert(enabled != null),
        assert(dismissal == null || key != null,
            'a key must be provided if slideToDismissDelegate is set'),
        assert(fastThreshold == null || fastThreshold >= .0,
            'fastThreshold must be positive'),
        fastThreshold = fastThreshold ?? _kFastThreshold,
        super(key: key);

  /// The widget below this widget in the tree.
  final Widget child;

  /// The controller that tracks the active [Slidable] and keep only one open.
  final SlidableController controller;

  /// A delegate that builds slide actions that appears when the child has been dragged
  /// down or to the right.
  final SlideActionDelegate actionDelegate;

  /// A delegate that builds slide actions that appears when the child has been dragged
  /// up or to the left.
  final SlideActionDelegate secondaryActionDelegate;

  /// The action pane that controls how the slide actions are animated;
  final Widget actionPane;

  /// A delegate that controls how to dismiss the item.
  final SlidableDismissal dismissal;

  /// Relative ratio between one slide action and the extent of the child.
  final double actionExtentRatio;

  /// The direction in which this widget can be slid.
  final Axis direction;

  /// The offset threshold the item has to be dragged in order to show all actions
  /// in the slide direction.
  ///
  /// Represented as a fraction, e.g. if it is 0.4 (the default), then the item
  /// has to be dragged at least 40% of the slide actions extent towards one direction to show all actions.
  final double showAllActionsThreshold;

  /// Defines the duration for card to go to final position or to come back to original position if threshold not reached.
  final Duration movementDuration;

  /// Specifies to close this slidable after the closest [Scrollable]'s position changed.
  ///
  /// Defaults to true.
  final bool closeOnScroll;

  /// Whether this slidable is interactive.
  ///
  /// If false, the child will not slid to show slide actions.
  ///
  /// Defaults to true.
  final bool enabled;

  /// The threshold used to know if a movement was fast and request to open/close the actions.
  final double fastThreshold;

  /// The state from the closest instance of this class that encloses the given context.
  static SlidableState of(BuildContext context) {
    final _SlidableScope scope =
        context.dependOnInheritedWidgetOfExactType<_SlidableScope>();
    return scope?.state;
  }

  final userTransactions user;

  @override
  SlidableState createState() => SlidableState();
}

/// The state of [Slidable] widget.
/// You can open or close the [Slidable] by calling the corresponding methods of
/// this object.
class SlidableState extends State<SlidableV2>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<SlidableV2> {
  @override
  void initState() {
    super.initState();
    _overallMoveController =
        AnimationController(duration: widget.movementDuration, vsync: this)
          ..addStatusListener(_handleDismissStatusChanged)
          ..addListener(_handleOverallPositionChanged);
    _initAnimations();
  }

  void _initAnimations() {
    //print("ANIMATE");
    _actionsMoveAnimation
        ?.removeStatusListener(_handleShowAllActionsStatusChanged);
    _dismissAnimation?.removeStatusListener(_handleShowAllActionsStatusChanged);

    _actionsMoveAnimation = CurvedAnimation(
      parent: _overallMoveController,
      curve: Interval(0.0, _totalActionsExtent),
    )..addStatusListener(_handleShowAllActionsStatusChanged);
    _dismissAnimation = CurvedAnimation(
      parent: _overallMoveController,
      curve: Interval(_totalActionsExtent, 1.0),
    )..addStatusListener(_handleShowAllActionsStatusChanged);
  }

  AnimationController _overallMoveController;
  Animation<double> get overallMoveAnimation => _overallMoveController.view;

  Animation<double> _actionsMoveAnimation;
  Animation<double> _dismissAnimation;

  AnimationController _resizeController;
  Animation<double> _resizeAnimation;

  double _dragExtent = 0.0;

  SlidableRenderingMode _renderingMode = SlidableRenderingMode.none;
  SlidableRenderingMode get renderingMode => _renderingMode;

  ScrollPosition _scrollPosition;
  bool _dragUnderway = false;
  Size _sizePriorToCollapse;
  bool _dismissing = false;

  SlideActionType _actionType = SlideActionType.primary;
  SlideActionType get actionType => _actionType;
  set actionType(SlideActionType value) {
    _actionType = value;
    _initAnimations();
  }

  int get _actionCount => _actionDelegate?.actionCount ?? 0;

  double get _totalActionsExtent => widget.actionExtentRatio * (_actionCount);

  double get _dismissThreshold {
    if (widget.dismissal == null)
      return _kDismissThreshold;
    else
      return widget.dismissal.dismissThresholds[actionType] ??
          _kDismissThreshold;
  }

  bool get _dismissible => widget.dismissal != null && _dismissThreshold < 1.0;

  @override
  bool get wantKeepAlive =>
      !widget.closeOnScroll &&
      (_overallMoveController?.isAnimating == true ||
          _resizeController?.isAnimating == true);

  /// The current actions that have to be shown.
  SlideActionDelegate get _actionDelegate =>
      actionType == SlideActionType.primary
          ? widget.actionDelegate
          : widget.secondaryActionDelegate;

  bool get _directionIsXAxis => widget.direction == Axis.horizontal;

  double get _overallDragAxisExtent {
    final Size size = context.size;
    return _directionIsXAxis ? size.width : size.height;
  }

  double get _actionsDragAxisExtent {
    return _overallDragAxisExtent * _totalActionsExtent;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeScrollingNotifierListener();
    _addScrollingNotifierListener();
  }

  @override
  void didUpdateWidget(SlidableV2 oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.closeOnScroll != oldWidget.closeOnScroll) {
      _removeScrollingNotifierListener();
      _addScrollingNotifierListener();
    }
  }

  void _addScrollingNotifierListener() {
    if (widget.closeOnScroll) {
      _scrollPosition = Scrollable.of(context)?.position;
      if (_scrollPosition != null)
        _scrollPosition.isScrollingNotifier.addListener(_isScrollingListener);
    }
  }

  void _removeScrollingNotifierListener() {
    if (_scrollPosition != null) {
      _scrollPosition.isScrollingNotifier.removeListener(_isScrollingListener);
    }
  }

  @override
  void dispose() {
    _overallMoveController.dispose();
    _resizeController?.dispose();
    _removeScrollingNotifierListener();
    widget.controller?._activeState = null;
    super.dispose();
  }

  /// Opens the [Slidable].
  /// By default it's open the [SlideActionType.primary] action pane, but you
  /// can modify this by setting [actionType].
  ///

  void open({SlideActionType actionType}) {
    widget.controller?.activeState = this;

    if (actionType != null && _actionType != actionType) {
      setState(() {
        this.actionType = actionType;
      });
    }
    if (_actionCount > 0) {
      print("OPEN=>" + widget.user.codewoiner);
      usersTransactionBloc.addToDelete(widget.user);
      _overallMoveController.animateTo(
        _totalActionsExtent,
        curve: Curves.easeIn,
        duration: widget.movementDuration,
      );
    } else {
      print("CLOSE=>" + widget.user.codewoiner);
      usersTransactionBloc.addToDelete(widget.user);
    }
  }

  /// Closes this [Slidable].
  void close() {
    if (!_overallMoveController.isDismissed) {
      if (widget.controller?.activeState == this) {
        widget.controller?.activeState = null;
      } else {
        _flingAnimationController();
      }
    }
  }

  void _flingAnimationController() {
    if (!_dismissing) {
      _overallMoveController.fling(velocity: -1.0);
    }
  }

  /// Dismisses this [Slidable].
  /// By default it's dismiss by showing the [SlideActionType.primary] action pane, but you
  /// can modify this by setting [actionType].
  void dismiss({SlideActionType actionType}) {
    if (_dismissible) {
      _dismissing = true;
      actionType ??= _actionType;
      if (actionType != _actionType) {
        setState(() {
          this.actionType = actionType;
        });
      }

      _overallMoveController.fling(velocity: 1.0);
    }
  }

  void _isScrollingListener() {
    if (!widget.closeOnScroll || _scrollPosition == null) {
      return;
    }

    // When a scroll starts close this.
    if (_scrollPosition.isScrollingNotifier.value) {
      close();
    }
  }

  void _handleDragStart(DragStartDetails details) {
    //print("HANDLE DRAG");
    _dragUnderway = true;
    widget.controller?.activeState = this;
    _dragExtent =
        _actionsMoveAnimation.value * _actionsDragAxisExtent * _dragExtent.sign;
    if (_overallMoveController.isAnimating) {
      _overallMoveController.stop();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (widget.controller != null && widget.controller.activeState != this) {
      return;
    }

    final double delta = details.primaryDelta;
    _dragExtent += delta;
    setState(() {
      actionType = _dragExtent.sign >= 0
          ? SlideActionType.primary
          : SlideActionType.secondary;
      if (_actionCount > 0) {
        if (_dismissible && !widget.dismissal.dragDismissible) {
          // If the widget is not dismissible by dragging, clamp drag result
          // so the widget doesn't slide past [_totalActionsExtent].

          _overallMoveController.value =
              (_dragExtent.abs() / _overallDragAxisExtent)
                  .clamp(0.0, _totalActionsExtent);
        } else {
          _overallMoveController.value =
              _dragExtent.abs() / _overallDragAxisExtent;
          // print(_overallMoveController.value);
        }
      }
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (widget.controller != null && widget.controller.activeState != this) {
      return;
    }

    _dragUnderway = false;
    final double velocity = details.primaryVelocity;
    final bool shouldOpen = velocity.sign == _dragExtent.sign;
    final bool fast = velocity.abs() > widget.fastThreshold;

    if (_dismissible && overallMoveAnimation.value > _totalActionsExtent) {
      // We are in a dismiss state.
      if (overallMoveAnimation.value >= _dismissThreshold) {
        dismiss();
      } else {
        open();
      }
    } else if (_actionsMoveAnimation.value >= widget.showAllActionsThreshold ||
        (shouldOpen && fast)) {
      open();
    } else {
      close();
    }
  }

  void _handleShowAllActionsStatusChanged(AnimationStatus status) {
    // Make sure to rebuild a last time, otherwise the slide action could
    // be scrambled.
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      setState(() {});
    }

    updateKeepAlive();
  }

  void _handleOverallPositionChanged() {
    final double value = _overallMoveController.value;
    if (value == _overallMoveController.lowerBound) {
      _renderingMode = SlidableRenderingMode.none;
    } else if (value <= _totalActionsExtent) {
      _renderingMode = SlidableRenderingMode.slide;
    } else {
      _renderingMode = SlidableRenderingMode.dismiss;
    }

    setState(() {});
  }

  void _handleDismissStatusChanged(AnimationStatus status) async {
    if (_dismissible) {
      if (status == AnimationStatus.completed &&
          _overallMoveController.value == _overallMoveController.upperBound &&
          !_dragUnderway) {
        if (widget.dismissal.onWillDismiss == null ||
            await widget.dismissal.onWillDismiss(actionType)) {
          _startResizeAnimation();
        } else {
          _dismissing = false;
          if (widget.dismissal?.closeOnCanceled == true) {
            close();
          } else {
            open();
          }
        }
      }
      updateKeepAlive();
    }
  }

  void _handleDismiss() {
    widget.controller?.activeState = null;
    final SlidableDismissal dismissal = widget.dismissal;
    if (dismissal.onDismissed != null) {
      assert(actionType != null);
      dismissal.onDismissed(actionType);
    }
  }

  void _startResizeAnimation() {
    assert(_overallMoveController != null);
    assert(_overallMoveController.isCompleted);
    assert(_resizeController == null);
    assert(_sizePriorToCollapse == null);
    final SlidableDismissal dismissal = widget.dismissal;
    if (dismissal.resizeDuration == null) {
      _handleDismiss();
    } else {
      _resizeController =
          AnimationController(duration: dismissal.resizeDuration, vsync: this)
            ..addListener(_handleResizeProgressChanged)
            ..addStatusListener((AnimationStatus status) => updateKeepAlive());
      _resizeController.forward();
      setState(() {
        _renderingMode = SlidableRenderingMode.resize;
        _sizePriorToCollapse = context.size;

        _resizeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
                parent: _resizeController, curve: _kResizeTimeCurve));
      });
    }
  }

  void _handleResizeProgressChanged() {
    if (_resizeController.isCompleted) {
      _handleDismiss();
    } else {
      widget.dismissal.onResize?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.

    Widget content = widget.child;

    if (!(!widget.enabled ||
        ((widget.actionDelegate == null ||
                widget.actionDelegate.actionCount == 0) &&
            (widget.secondaryActionDelegate == null ||
                widget.secondaryActionDelegate.actionCount == 0)))) {
      if (actionType == SlideActionType.primary &&
              widget.actionDelegate != null &&
              widget.actionDelegate.actionCount > 0 ||
          actionType == SlideActionType.secondary &&
              widget.secondaryActionDelegate != null &&
              widget.secondaryActionDelegate.actionCount > 0) {
        if (_dismissible) {
          content = widget.dismissal;

          if (_resizeAnimation != null) {
            // we've been dragged aside, and are now resizing.
            assert(() {
              if (_resizeAnimation.status != AnimationStatus.forward) {
                assert(_resizeAnimation.status == AnimationStatus.completed);
                throw FlutterError(
                    'A dismissed Slidable widget is still part of the tree.\n'
                    'Make sure to implement the onDismissed handler and to immediately remove the Slidable\n'
                    'widget from the application once that handler has fired.');
              }
              return true;
            }());

            content = SizeTransition(
              sizeFactor: _resizeAnimation,
              axis: _directionIsXAxis ? Axis.vertical : Axis.horizontal,
              child: SizedBox(
                width: _sizePriorToCollapse.width,
                height: _sizePriorToCollapse.height,
                child: content,
              ),
            );
          }
        } else {
          content = widget.actionPane;
        }
      }

      content = GestureDetector(
        onHorizontalDragStart: _directionIsXAxis ? _handleDragStart : null,
        onHorizontalDragUpdate: _directionIsXAxis ? _handleDragUpdate : null,
        onHorizontalDragEnd: _directionIsXAxis ? _handleDragEnd : null,
        onVerticalDragStart: _directionIsXAxis ? null : _handleDragStart,
        onVerticalDragUpdate: _directionIsXAxis ? null : _handleDragUpdate,
        onVerticalDragEnd: _directionIsXAxis ? null : _handleDragEnd,
        behavior: HitTestBehavior.opaque,
        child: content,
      );
    }

    return _SlidableScope(
      state: this,
      child: SlidableData(
        actionType: actionType,
        renderingMode: _renderingMode,
        totalActionsExtent: _totalActionsExtent,
        dismissThreshold: _dismissThreshold,
        dismissible: _dismissible,
        actionDelegate: _actionDelegate,
        overallMoveAnimation: overallMoveAnimation,
        actionsMoveAnimation: _actionsMoveAnimation,
        dismissAnimation: _dismissAnimation,
        slidable: widget,
        actionExtentRatio: widget.actionExtentRatio,
        direction: widget.direction,
        child: content,
      ),
    );
  }
}
