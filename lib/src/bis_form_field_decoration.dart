import 'package:flutter/material.dart';

import 'package:bottom_input_system/bottom_input_system.dart';

/// Extends [FormField] and add a `decoration` (InputDecoration) property
///
/// This class override `decoration.enable` with [enable] value
class BisFormFieldDecoration<T> extends BisFormField<T> {
  const BisFormFieldDecoration({
    super.key,
    super.onSaved,
    super.initialValue,
    super.autovalidateMode,
    super.enabled = true,
    super.validator,
    super.restorationId,
    required super.name,
    super.valueTransformer,
    super.onChanged,
    super.onReset,
    super.focusNode,
    required super.builder,
    required super.bsBuilder,
    this.decoration = const InputDecoration(),
  });
  final InputDecoration decoration;

  @override
  BisFormFieldDecorationState<BisFormFieldDecoration<T>, T> createState() =>
      BisFormFieldDecorationState<BisFormFieldDecoration<T>, T>();
}

class BisFormFieldDecorationState<F extends BisFormFieldDecoration<T>, T>
    extends BisFormFieldState<BisFormField<T>, T> {
  @override
  F get widget => super.widget as F;

  InputDecoration get decoration => widget.decoration.copyWith(
        errorText: widget.enabled || readOnly
            ? widget.decoration.errorText ?? errorText
            : null,
        enabled: widget.enabled,
      );

  @override
  bool get hasError => super.hasError || widget.decoration.errorText != null;

  @override
  bool get isValid => super.isValid && widget.decoration.errorText == null;
}
