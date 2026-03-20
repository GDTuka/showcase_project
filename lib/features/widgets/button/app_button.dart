import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:showcase_project/features/theme/theme.dart';

class AppButton extends StatefulWidget {
  const AppButton._({
    required this.text,
    required this.colors,
    this.isEnabled = true,
    this.onTap,
    this.onAsyncTap,
    this.icon,
    this.isExpanded = false,
    this.isOutlined = false,
    this.isTextOnlyVariant = false,
    this.loadingCallback,
    this.textStyle,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
  }) : assert(
         (onTap != null && onAsyncTap == null) || (onTap == null && onAsyncTap != null),
         'Required only 1 onTap method',
       );

  final bool isEnabled;
  final IconData? icon;
  final bool isExpanded;
  final bool isOutlined;
  final bool isTextOnlyVariant;
  final String text;
  final ButtonColors colors;
  final VoidCallback? onTap;
  final AsyncCallback? onAsyncTap;
  final void Function(bool isLoading)? loadingCallback;
  final TextStyle? textStyle;
  final int? maxLines;
  final TextOverflow? overflow;

  factory AppButton.primaryFilled({
    required String text,
    bool isEnabled = true,
    VoidCallback? onTap,
    AsyncCallback? onAsyncTap,
    IconData? icon,
    bool isExpanded = false,
    TextStyle? textStyle,
    int? maxLines,
    TextOverflow? overflow,
  }) => AppButton._(
    text: text,
    colors: ButtonColors.primary,
    isEnabled: isEnabled,
    isExpanded: isExpanded,
    icon: icon,
    onTap: onTap,
    onAsyncTap: onAsyncTap,
    textStyle: textStyle,
    maxLines: maxLines,
    overflow: overflow,
  );
  factory AppButton.secondaryFilled({
    required String text,
    bool isEnabled = true,
    VoidCallback? onTap,
    AsyncCallback? onAsyncTap,
    IconData? icon,
    bool isExpanded = false,
    TextStyle? textStyle,
    int? maxLines,
    TextOverflow? overflow,
  }) => AppButton._(
    text: text,
    colors: ButtonColors.secondary,
    isEnabled: isEnabled,
    isExpanded: isExpanded,
    icon: icon,
    onTap: onTap,
    onAsyncTap: onAsyncTap,
    textStyle: textStyle,
    maxLines: maxLines,
    overflow: overflow,
  );
  factory AppButton.secondaryFixedFilled({
    required String text,
    bool isEnabled = true,
    VoidCallback? onTap,
    AsyncCallback? onAsyncTap,
    IconData? icon,
    bool isExpanded = false,
    TextStyle? textStyle,
    int? maxLines,
    TextOverflow? overflow,
  }) => AppButton._(
    text: text,
    colors: ButtonColors.secondaryFixed,
    isEnabled: isEnabled,
    isExpanded: isExpanded,
    icon: icon,
    onTap: onTap,
    onAsyncTap: onAsyncTap,
    textStyle: textStyle,
    maxLines: maxLines,
    overflow: overflow,
  );

  factory AppButton.errorFilled({
    required String text,
    bool isEnabled = true,
    VoidCallback? onTap,
    AsyncCallback? onAsyncTap,
    IconData? icon,
    bool isExpanded = false,
    TextStyle? textStyle,
    int? maxLines,
    TextOverflow? overflow,
  }) => AppButton._(
    text: text,
    colors: ButtonColors.error,
    isEnabled: isEnabled,
    isExpanded: isExpanded,
    icon: icon,
    onTap: onTap,
    onAsyncTap: onAsyncTap,
    textStyle: textStyle,
    maxLines: maxLines,
    overflow: overflow,
  );

  factory AppButton.primaryOutlined({
    required String text,
    bool isEnabled = true,
    VoidCallback? onTap,
    AsyncCallback? onAsyncTap,
    IconData? icon,
    bool isExpanded = false,
    TextStyle? textStyle,
    int? maxLines,
    TextOverflow? overflow,
  }) => AppButton._(
    text: text,
    colors: ButtonColors.primary,
    isEnabled: isEnabled,
    isExpanded: isExpanded,
    icon: icon,
    isTextOnlyVariant: true,
    onTap: onTap,
    onAsyncTap: onAsyncTap,
    textStyle: textStyle,
    maxLines: maxLines,
    overflow: overflow,
  );

  factory AppButton.secondaryOutlined({
    required String text,
    bool isEnabled = true,
    VoidCallback? onTap,
    AsyncCallback? onAsyncTap,
    IconData? icon,
    bool isExpanded = false,
    TextStyle? textStyle,
    int? maxLines,
    TextOverflow? overflow,
  }) => AppButton._(
    text: text,
    colors: ButtonColors.secondary,
    isEnabled: isEnabled,
    isExpanded: isExpanded,
    icon: icon,
    isOutlined: true,
    onTap: onTap,
    onAsyncTap: onAsyncTap,
    textStyle: textStyle,
    maxLines: maxLines,
    overflow: overflow,
  );

  factory AppButton.secondaryFixedOutlined({
    required String text,
    bool isEnabled = true,
    VoidCallback? onTap,
    AsyncCallback? onAsyncTap,
    IconData? icon,
    bool isExpanded = false,
    TextStyle? textStyle,
    int? maxLines,
    TextOverflow? overflow,
  }) => AppButton._(
    text: text,
    colors: ButtonColors.secondaryFixed,
    isEnabled: isEnabled,
    isExpanded: isExpanded,
    icon: icon,
    isOutlined: true,
    onTap: onTap,
    onAsyncTap: onAsyncTap,
    textStyle: textStyle,
    maxLines: maxLines,
    overflow: overflow,
  );

  factory AppButton.errorOutlined({
    required String text,
    bool isEnabled = true,
    VoidCallback? onTap,
    AsyncCallback? onAsyncTap,
    IconData? icon,
    bool isExpanded = false,
    TextStyle? textStyle,
    int? maxLines,
    TextOverflow? overflow,
  }) => AppButton._(
    text: text,
    colors: ButtonColors.error,
    isEnabled: isEnabled,
    isExpanded: isExpanded,
    icon: icon,
    isOutlined: true,
    onTap: onTap,
    onAsyncTap: onAsyncTap,
    textStyle: textStyle,
    maxLines: maxLines,
    overflow: overflow,
  );

  factory AppButton.textOnly({
    required String text,
    bool isEnabled = true,
    VoidCallback? onTap,
    AsyncCallback? onAsyncTap,
    IconData? icon,
    bool isExpanded = false,
    TextStyle? textStyle,
    int? maxLines,
    TextOverflow? overflow,
  }) => AppButton._(
    text: text,
    colors: ButtonColors.primary,
    isEnabled: isEnabled,
    isExpanded: isExpanded,
    icon: icon,
    isOutlined: true,
    onTap: onTap,
    onAsyncTap: onAsyncTap,
    textStyle: textStyle,
    maxLines: maxLines,
    overflow: overflow,
  );

  /// Special constructor for text-only buttons (like TextButton)
  factory AppButton.textLike({
    required String text,
    bool isEnabled = true,
    VoidCallback? onTap,
    AsyncCallback? onAsyncTap,
    TextStyle? textStyle,
    int? maxLines,
    TextOverflow? overflow,
  }) => AppButton._(
    text: text,
    colors: ButtonColors.primary,
    isEnabled: isEnabled,
    isExpanded: false,
    icon: null,
    isTextOnlyVariant: true,
    onTap: onTap,
    onAsyncTap: onAsyncTap,
    textStyle: textStyle,
    maxLines: maxLines,
    overflow: overflow,
  );

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  late Color backgroundColor;
  late Color foregroundColor;

  bool isLoading = false;

  bool get isTextOnly => widget.isTextOnlyVariant;

  @override
  void didChangeDependencies() {
    final colors = widget.colors.data(context);

    backgroundColor = colors.$1;
    foregroundColor = colors.$2;
    super.didChangeDependencies();
  }

  Future<void> onAsyncTap() async {
    setState(() => isLoading = true);
    if (widget.loadingCallback != null) widget.loadingCallback!(true);
    await widget.onAsyncTap!();
    setState(() => isLoading = false);
    if (widget.loadingCallback != null) widget.loadingCallback!(false);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isTextOnly ? Colors.transparent : null,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: !widget.isEnabled || isLoading
            ? null
            : widget.onTap != null
            ? () => widget.onTap!()
            : () => onAsyncTap(),
        child: Ink(
          padding: isTextOnly
              ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
              : const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            border: isTextOnly
                ? null
                : Border.all(
                    width: 1,
                    style: BorderStyle.solid,
                    color: widget.isOutlined
                        ? foregroundColor
                        : backgroundColor.withValues(alpha: widget.isEnabled ? null : 0.8),
                  ),
            color: isTextOnly
                ? null
                : widget.isEnabled
                ? backgroundColor
                : backgroundColor.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: isLoading ? 0 : 1,
                child: isTextOnly
                    ? Opacity(
                        opacity: widget.isEnabled ? 1.0 : 0.5,
                        child: Text(
                          widget.text,
                          style: (widget.textStyle ?? context.textStyles.button).copyWith(color: foregroundColor),
                          maxLines: widget.maxLines,
                          overflow: widget.overflow,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Row(
                        mainAxisSize: widget.isExpanded ? MainAxisSize.max : MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.icon != null) ...[
                            Icon(widget.icon, color: foregroundColor),
                            const SizedBox(width: 8),
                          ],
                          Flexible(
                            child: Text(
                              widget.text,
                              style: widget.textStyle ?? context.textStyles.button.copyWith(color: foregroundColor),
                              maxLines: widget.maxLines,
                              overflow: widget.overflow,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
              ),
              if (isLoading)
                Positioned.fill(
                  child: Center(
                    child: SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: foregroundColor),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

extension ButtonCopyWith on AppButton {
  AppButton copyWith({
    String? text,
    bool? isEnabled,
    IconData? icon,
    bool? isExpanded,
    bool? isOutlined,
    bool? isTextOnlyVariant,
    ButtonColors? colors,
    VoidCallback? onTap,
    AsyncCallback? onAsyncTap,
    void Function(bool isLoading)? loadingCallback,
    TextStyle? textStyle,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppButton._(
      text: text ?? this.text,
      colors: colors ?? this.colors,
      isEnabled: isEnabled ?? this.isEnabled,
      icon: icon ?? this.icon,
      isExpanded: isExpanded ?? this.isExpanded,
      isOutlined: isOutlined ?? this.isOutlined,
      isTextOnlyVariant: isTextOnlyVariant ?? this.isTextOnlyVariant,
      onTap: onTap ?? this.onTap,
      onAsyncTap: onAsyncTap ?? this.onAsyncTap,
      loadingCallback: loadingCallback ?? this.loadingCallback,
      textStyle: textStyle ?? this.textStyle,
      maxLines: maxLines ?? this.maxLines,
      overflow: overflow ?? this.overflow,
    );
  }
}

class CounterButton extends StatefulWidget {
  const CounterButton._({
    required this.value,
    this.isEnabled = true,
    this.isOutlined = false,
    this.isExpanded = false,
    this.onAddTap,
    this.onAddAsyncTap,
    this.onRemoveTap,
    this.onRemoveAsyncTap,
  }) : assert(
         (onAddTap != null && onRemoveTap != null && onAddAsyncTap == null && onRemoveAsyncTap == null) ||
             (onAddAsyncTap != null && onRemoveAsyncTap != null && onAddTap == null && onRemoveTap == null),
         'Required only 1 type of methods (sync or async).',
       );

  final int value;
  final bool isEnabled;
  final bool isOutlined;
  final bool isExpanded;
  final VoidCallback? onAddTap;
  final AsyncCallback? onAddAsyncTap;
  final VoidCallback? onRemoveTap;
  final AsyncCallback? onRemoveAsyncTap;

  factory CounterButton.outlined({
    required int value,
    bool isEnabled = true,
    bool isExpanded = false,
    VoidCallback? onAddTap,
    AsyncCallback? onAddAsyncTap,
    VoidCallback? onRemoveTap,
    AsyncCallback? onRemoveAsyncTap,
  }) => CounterButton._(
    value: value,
    isEnabled: isEnabled,
    isExpanded: isExpanded,
    onAddTap: onAddTap,
    onAddAsyncTap: onAddAsyncTap,
    onRemoveTap: onRemoveTap,
    onRemoveAsyncTap: onRemoveAsyncTap,
  );

  factory CounterButton.filled({
    required int value,
    bool isEnabled = true,
    bool isExpanded = false,
    VoidCallback? onAddTap,
    AsyncCallback? onAddAsyncTap,
    VoidCallback? onRemoveTap,
    AsyncCallback? onRemoveAsyncTap,
  }) => CounterButton._(
    value: value,
    isEnabled: isEnabled,
    isOutlined: true,
    isExpanded: isExpanded,
    onAddTap: onAddTap,
    onAddAsyncTap: onAddAsyncTap,
    onRemoveTap: onRemoveTap,
    onRemoveAsyncTap: onRemoveAsyncTap,
  );

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

enum Operation { add, remove }

class _CounterButtonState extends State<CounterButton> {
  bool isLoading = false;

  void onAsyncTap(Operation operationType) async {
    if (isLoading || !widget.isEnabled) return;
    setState(() => isLoading = true);
    try {
      await (operationType == Operation.add ? widget.onAddAsyncTap!() : widget.onRemoveAsyncTap!());
      setState(() => isLoading = false);
    } on Object {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.isEnabled ? 1 : 0.63,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: widget.isOutlined ? context.colors.onPrimary : context.colors.primary),
          borderRadius: BorderRadius.circular(30),
          color: widget.isOutlined ? context.colors.onPrimary : context.colors.onPrimary,
        ),
        child: Row(
          mainAxisSize: widget.isExpanded ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (!widget.isEnabled || isLoading)
                  ? null
                  : widget.onRemoveTap != null
                  ? () => widget.onRemoveTap!()
                  : () => onAsyncTap(Operation.remove),
              child: Icon(Icons.remove, color: context.colors.primary, size: 20),
            ),
            SizedBox(
              height: (context.textStyles.button.fontSize ?? 10) * 1.5,
              width: 46,
              child: Center(
                child: isLoading
                    ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : Text(
                        widget.value.toString(),
                        style: context.textStyles.button.copyWith(color: context.colors.onPrimary),
                      ),
              ),
            ),
            GestureDetector(
              onTap: (!widget.isEnabled || isLoading)
                  ? null
                  : widget.onAddTap != null
                  ? () => widget.onAddTap!()
                  : () => onAsyncTap(Operation.add),
              child: Icon(Icons.add, color: context.colors.primary, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class VariantButton extends StatelessWidget {
  const VariantButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.isEnabled,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Opacity(
        opacity: isEnabled ? 1 : 0.63,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: isSelected ? context.colors.primary : context.colors.onSurface),
            borderRadius: BorderRadius.circular(30),
            color: context.colors.onSurface,
          ),
          child: Opacity(
            opacity: isEnabled ? 1 : 0.63,
            child: Text(text, style: context.textStyles.button.copyWith(color: context.colors.primary)),
          ),
        ),
      ),
    );
  }
}

enum ButtonColors {
  primary,
  secondary,
  secondaryFixed,
  error;

  (Color accentColor, Color secondColor) data(BuildContext context) => switch (this) {
    ButtonColors.primary => (context.colors.primary, context.colors.onPrimary),
    ButtonColors.secondary => (context.colors.secondary, context.colors.onSecondary),
    ButtonColors.secondaryFixed => (context.colors.secondary, context.colors.onPrimary),
    ButtonColors.error => (context.colors.error, context.colors.onError),
  };
}
