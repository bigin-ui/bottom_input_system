import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bottom_input_system/bottom_input_system.dart';
import 'package:bottom_input_system/src/extensions/generic_validator.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../bis_form_field_view.dart';

/// Field for Dropdown button
class BisSelection<T> extends BisFormFieldDecoration<T> {
  /// The list of items the user can select.
  ///
  /// If the [onChanged] callback is null or the list of items is null
  /// then the dropdown button will be disabled, i.e. its arrow will be
  /// displayed in grey and it will not respond to input. A disabled button
  /// will display the [disabledHint] widget if it is non-null.
  ///
  /// If [decoration.hint] and variations is non-null and [disabledHint] is null,
  /// the [decoration.hint] widget will be displayed instead.
  final List<DropdownMenuItem<T>> items;

  /// The maximum height of the menu.
  ///
  /// The maximum height of the menu must be at least one row shorter than
  /// the height of the app's view. This ensures that a tappable area
  /// outside of the simple menu is present so the user can dismiss the menu.
  ///
  /// If this property is set above the maximum allowable height threshold
  /// mentioned above, then the menu defaults to being padded at the top
  /// and bottom of the menu by at one menu item's height.
  final double? menuMaxHeight;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// By default, platform-specific feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool? enableFeedback;

  /// Defines how the hint or the selected item is positioned within the button.
  ///
  /// This property must not be null. It defaults to [AlignmentDirectional.centerStart].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// Creates field for Dropdown button
  BisSelection({
    super.key,
    required super.name,
    super.fieldType = FieldType.selection,
    super.validator,
    super.initialValue,
    super.decoration,
    super.onChanged,
    super.valueTransformer,
    super.enabled,
    super.onSaved,
    super.autovalidateMode = AutovalidateMode.disabled,
    super.onReset,
    super.restorationId,
    required this.items,
    this.menuMaxHeight,
    this.enableFeedback,
    this.alignment = AlignmentDirectional.centerStart,
  }) : super(
          builder: (FormFieldState<T?> field) {
            final state = field as _BisSelectionState<T>;

            return BisFormFieldView(
              formBuilderState: state.formBuilderState,
              name: name,
              value: state.value,
              hintText: decoration.hintText,
              type: fieldType,
            );
          },
          bsBuilder: (FormFieldState<T?> field, StateSetter? bsSetState) {
            final state = field as _BisSelectionState<T>;
            final scrollController = ItemScrollController();

            return Container(
              constraints: BoxConstraints(maxHeight: menuMaxHeight ?? 230),
              decoration: BoxDecoration(
                color: const Color(0xfff2f2f2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ScrollablePositionedList.builder(
                padding: const EdgeInsets.all(8),
                initialAlignment: 0.4,
                initialScrollIndex: max(
                    items.map((e) => e.value).toList().indexOf(state.value), 0),
                itemScrollController: scrollController,
                physics: const ClampingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  var itemValue = items[index].value as T;
                  bool isCurrentItem =
                      state.value.toString() == itemValue.toString();

                  return GestureDetector(
                    onTap: () {
                      state.didChange(itemValue);
                      bsSetState?.call(() {});
                      scrollController.scrollTo(
                        index: index,
                        duration: const Duration(milliseconds: 100),
                        alignment: 0.4,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isCurrentItem
                            ? const Color(0xffffffff)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: isCurrentItem
                            ? const [
                                BoxShadow(
                                  color: Color(0x10000000),
                                  offset: Offset(0, 2),
                                  blurRadius: 12,
                                )
                              ]
                            : [],
                      ),
                      padding: const EdgeInsets.all(12),
                      margin: EdgeInsets.only(top: index > 0 ? 2 : 0),
                      child: Text(
                        itemValue.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff333333),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );

  @override
  BisFormFieldDecorationState<BisSelection<T>, T> createState() =>
      _BisSelectionState<T>();
}

class _BisSelectionState<T>
    extends BisFormFieldDecorationState<BisSelection<T>, T> {
  @override
  void didUpdateWidget(covariant BisSelection<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldValues = oldWidget.items.map((e) => e.value).toList();
    final currentlyValues = widget.items.map((e) => e.value).toList();
    final oldChilds = oldWidget.items.map((e) => e.child.toString()).toList();
    final currentlyChilds =
        widget.items.map((e) => e.child.toString()).toList();

    if (!currentlyValues.contains(initialValue) &&
        !initialValue.emptyValidator()) {
      assert(
        currentlyValues.contains(initialValue) && initialValue.emptyValidator(),
        'The initialValue [$initialValue] is not in the list of items or is not null or empty. '
        'Please provide one of the items as the initialValue or update your initial value. '
        'By default, will apply [null] to field value',
      );
      setValue(null);
    }

    if ((!listEquals(oldChilds, currentlyChilds) ||
            !listEquals(oldValues, currentlyValues)) &&
        (currentlyValues.contains(initialValue) ||
            initialValue.emptyValidator())) {
      setValue(initialValue);
    }
  }
}
