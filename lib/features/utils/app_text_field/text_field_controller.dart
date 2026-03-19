import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:showcase_project/features/theme/theme.dart';

/// Перечисление возможных состояний текстового поля
enum FieldStateType {
  /// Обычное состояние по умолчанию
  none,

  /// Состояние ошибки (невалидные данные)
  error,

  /// Состояние успеха (данные валидны)
  success,

  /// Поле отключено и недоступно для взаимодействия
  disable,

  /// Состояние загрузки/асинхронной валидации
  busy;

  /// Возвращает цвет, соответствующий текущему состоянию
  /// [BuildContext context] - контекст для доступа к теме
  Color? color(BuildContext context) => switch (this) {
    FieldStateType.none => null,
    FieldStateType.error => context.colors.error,
    FieldStateType.success => context.colors.success,
    FieldStateType.disable => null,
    FieldStateType.busy => null,
  };
}

/// Класс, представляющий результат работы валидатора поля
class ValidatorResponse {
  /// Создает ответ валидатора
  /// [FieldStateType state] - новое состояние поля
  /// [String? message] - опциональное сообщение (например, текст ошибки)
  ValidatorResponse(this.state, {this.message});

  /// Состояние, в которое должно перейти поле
  final FieldStateType state;

  /// Сообщение, которое будет отображено под полем
  final String? message;
}

/// Расширенный контроллер текстового поля
/// Добавляет поддержку масок, валидации, управления состоянием и фокусом
class AppTextController extends TextEditingController {
  /// Создает новый контроллер текстового поля
  /// [String? text] - начальный текст
  /// [String? mask] - маска для ввода (например, '+7(###)###-##-##')
  /// [Map<String, RegExp>? filter] - фильтры для символов маски
  /// [bool enabled] - активно ли поле
  /// [FieldStateType fieldState] - начальное состояние поля
  /// [String? label] - текст лейбла
  /// [String? message] - текст сообщения под полем
  /// [Future<ValidatorResponse> Function(String? value)? validator] - функция валидации
  /// [TextInputType keyboardType] - тип клавиатуры
  /// [bool? obscure] - скрывать ли вводимый текст (для паролей)
  /// [Duration debounceDuration] - задержка перед вызовом валидатора при вводе
  /// [VoidCallback? onUpdate] - коллбек, вызываемый при любом изменении
  /// [bool enableSelection] - разрешено ли выделение текста
  /// [List<TextInputFormatter>? formatter] - дополнительные форматтеры
  /// [FocusNode? focusNode] - узел фокуса (создается автоматически, если не передан)
  AppTextController({
    super.text,
    String? mask,
    Map<String, RegExp>? filter,
    this.enabled = true,
    this.fieldState = FieldStateType.none,
    this.label,
    this.message,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscure,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.onUpdate,
    this.enableSelection = true,
    this.formatter,
    FocusNode? focusNode,
  }) : _mask = mask,
       focusNode = focusNode ?? FocusNode() {
    if (mask != null) {
      initMask(mask: mask, filter: filter);
    }
  }

  /// Текст лейбла поля
  String? label;

  /// Текст сообщения (ошибки/подсказки) под полем
  String? message;

  /// Флаг активности поля
  bool enabled;

  /// Асинхронная функция валидации значения
  Future<ValidatorResponse> Function(String? value)? validator;

  /// Текущее состояние поля (ошибка, успех и т.д.)
  FieldStateType fieldState;

  /// Коллбек, вызываемый при обновлении значения
  final VoidCallback? onUpdate;

  /// Разрешено ли выделение текста
  bool enableSelection;

  /// Список дополнительных форматтеров ввода
  List<TextInputFormatter>? formatter;

  /// Узел для управления фокусом поля
  FocusNode focusNode;

  /// Задержка перед вызовом валидации (debounce)
  final Duration debounceDuration;

  /// Внутреннее хранение строки маски
  final String? _mask;

  /// Возвращает текущую строку маски
  String? get mask => _mask;

  /// Внутренний инстанс форматтера маски
  MaskTextInputFormatter? _maskFormatter;

  /// Возвращает активный форматтер маски
  /// Выбрасывает исключение, если маска не была инициализирована
  MaskTextInputFormatter get maskFormatter => _maskFormatter!;

  /// Тип клавиатуры для поля
  TextInputType keyboardType;

  /// Возвращает текст с примененной маской (как он виден в поле)
  String get masked => text;

  /// Возвращает текст без символов маски (чистое значение)
  String get unmasked => _maskFormatter?.getUnmaskedText() ?? text;

  /// Флаг скрытия текста (для паролей)
  bool? obscure;

  /// Инициализирует форматтер маски
  /// [String? mask] - строка маски
  /// [Map<String, RegExp>? filter] - правила фильтрации символов маски
  void initMask({String? mask, Map<String, RegExp>? filter}) {
    _maskFormatter = MaskTextInputFormatter(mask: mask, filter: filter);
  }

  /// Обновляет текущую маску
  /// Если форматтер не был создан, создает его
  void updateMask({String? mask, Map<String, RegExp>? filter}) {
    if (_maskFormatter == null) initMask(mask: mask, filter: filter);
    value = maskFormatter.updateMask(mask: mask, filter: filter);
  }

  /// Очищает текущую маску, убирая все правила форматирования
  void clearMask() {
    value = maskFormatter.updateMask(mask: '');
  }

  /// Запрашивает фокус для привязанного текстового поля
  void requestFocus() {
    focusNode.requestFocus();
  }

  /// Обновляет состояние поля и опционально текст сообщения
  /// Уведомляет слушателей (перерисовывает UI)
  /// [FieldStateType stateType] - новое состояние
  /// [String? newMessage] - новое сообщение
  void updateFieldState(FieldStateType stateType, [String? newMessage]) {
    fieldState = stateType;
    if (newMessage != null) {
      message = newMessage;
    }
    notifyListeners();
  }

  /// Обновляет статус активности поля
  /// Уведомляет слушателей (перерисовывает UI)
  /// [bool enable] - новое значение активности
  void updateEnable({required bool enable}) {
    enabled = enable;
    notifyListeners();
  }
}
