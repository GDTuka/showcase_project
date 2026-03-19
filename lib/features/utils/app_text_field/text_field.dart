// ignore_for_file: library_private_types_in_public_api
import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showcase_project/features/theme/theme.dart';
import 'package:showcase_project/features/utils/app_text_field/text_field_controller.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.nextFocusNode,
    this.keyboardType = TextInputType.text,
    TextInputAction? textInputAction,
    this.maxLines = 1,
    this.minLines,
    this.textCapitalization = TextCapitalization.sentences,
    this.initialFocus = false,
    this.canUnfocus = true,
    this.onTap,
    this.readOnly = false,
    this.maxLength,
    this.additionalText,
    this.textAlign,
    this.textStyle,
    this.icon,
    this.onFieldSubmitted,
    this.autofillHints,
    this.scrollPadding,
  }) : textInputAction = textInputAction ?? (nextFocusNode != null ? TextInputAction.next : textInputAction);

  final AppTextController controller;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final TextCapitalization textCapitalization;
  final FocusNode? nextFocusNode;
  final VoidCallback? onTap;
  final bool readOnly;
  final int? maxLength;
  final String? additionalText;
  final TextStyle? textStyle;
  final IconData? icon;
  final bool canUnfocus;
  final bool initialFocus;
  final TextAlign? textAlign;
  final Iterable<String>? autofillHints;

  final EdgeInsets? scrollPadding;

  final ValueChanged<String>? onFieldSubmitted;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  Future<void> _launchValidator(String? value) async {
    EasyDebounce.debounce(_debounceKey, _controller.debounceDuration, () async {
      _controller.message = null;
      _updateStylesByState(FieldStateType.busy);
      final ValidatorResponse res = await _controller.validator!(value);
      _controller.message = res.message;
      _fieldState = res.state;
      _controller.fieldState = res.state;
      _updateStylesByState(res.state);
    });
  }

  BoxConstraints _suffixIconConstraints() {
    if (_controller.fieldState == FieldStateType.busy) {
      return const BoxConstraints(maxWidth: 14, maxHeight: 14);
    }
    return const BoxConstraints();
  }

  String? get _additionalText {
    if (_controller.message == null && _controller.fieldState == FieldStateType.none) {
      return widget.additionalText;
    }
    return _controller.message;
  }

  /// controller
  AppTextController get _controller => widget.controller;

  /// Completer for notrmal validator work
  final Completer<void> _validationInited = Completer<void>();

  /// Current widget state
  late FieldStateType _fieldState;

  final String _debounceKey = 'debounce_app_text_field';

  late bool _enable;

  List<TextInputFormatter> formatter = [];

  late OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: context.colors.surface),
  );

  late OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: context.colors.primary, width: 2),
  );

  void _updateStylesByState(FieldStateType state) {
    switch (state) {
      case FieldStateType.error:
        border = border.copyWith(borderSide: BorderSide(color: context.colors.error));

      case FieldStateType.success:
        border = border.copyWith(borderSide: BorderSide(color: context.colors.onPrimary));

      case FieldStateType.none:
        border = border.copyWith(borderSide: BorderSide(color: context.colors.surface));

      case FieldStateType.disable:
        border = border.copyWith(borderSide: BorderSide(color: context.colors.surface));

      case FieldStateType.busy:
        border = border.copyWith(borderSide: BorderSide(color: context.colors.surface));
    }
    setState(() {});
  }

  /// Request next focus if [nextFocusNode] is not null
  void _onEditingComplete() {
    if (widget.nextFocusNode == null) {
      if (widget.canUnfocus == true) {
        FocusScope.of(context).unfocus();
      } else {
        FocusScope.of(context).requestFocus();
      }
    } else {
      FocusScope.of(context).requestFocus(widget.nextFocusNode);
    }
  }

  void _onFieldStateUpdate() {
    final state = _controller.fieldState;
    _updateStylesByState(state);
  }

  void _onUpdateEnable() {
    _enable = _controller.enabled;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _fieldState = _controller.fieldState;

    _enable = _controller.enabled;

    if (_controller.formatter != null) formatter = _controller.formatter!;
    if (_controller.mask != null) formatter.add(_controller.maskFormatter);

    _controller
      ..addListener(_onFieldStateUpdate)
      ..addListener(_onUpdateEnable);

    _validationInited.complete();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onFieldStateUpdate)
      ..removeListener(_onUpdateEnable);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      controller: _controller,
      autofocus: widget.initialFocus,
      focusNode: _controller.focusNode,
      cursorColor: context.colors.primary,
      inputFormatters: formatter,
      enabled: _enable,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      style: context.textStyles.body1,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      onTap: widget.onTap,
      autofillHints: widget.autofillHints,
      contextMenuBuilder: (context, editableTextState) => AdaptiveTextSelectionToolbar.buttonItems(
        anchors: editableTextState.contextMenuAnchors,
        buttonItems: editableTextState.contextMenuButtonItems,
      ),
      scrollPadding: widget.scrollPadding ?? EdgeInsets.zero,
      obscureText: _controller.obscure ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: (value) async {
        _controller.onUpdate?.call();
        setState(() {});
        if (_controller.validator != null) await _launchValidator(value);
      },
      onEditingComplete: _onEditingComplete,
      validator: (_) {
        if (_fieldState != _controller.fieldState) {
          _fieldState = _controller.fieldState;
        }
        return null;
      },
      textAlign: widget.textAlign ?? TextAlign.start,
      decoration: InputDecoration(
        floatingLabelStyle: context.textStyles.caption.copyWith(
          color: _controller.focusNode.hasFocus ? context.colors.primary : _fieldState.color(context),
        ),
        labelStyle: context.textStyles.body1,
        labelText: _controller.label,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        border: border,
        errorBorder: border,
        enabledBorder: border,
        focusedBorder: focusedBorder,
        focusedErrorBorder: border,
        disabledBorder: border,
        errorMaxLines: 3,
        prefixIcon: widget.icon != null ? Icon(widget.icon, color: context.colors.onPrimary) : null,
        suffixIconConstraints: _suffixIconConstraints(),
        counter: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (_additionalText != null)
              Expanded(
                child: Text(
                  _additionalText ?? '',
                  style: context.textStyles.body2.copyWith(color: _fieldState.color(context)),
                ),
              ),
            if (widget.maxLength != null) Text('${_controller.text.length}/${widget.maxLength}'),
          ],
        ),
      ),
    );
  }
}
