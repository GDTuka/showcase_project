---
name: textfieldskill
description: A brief description, shown to the model to help it understand when to use this skill
---
## Обзор
`AppTextField` - это кастомный виджет текстового поля с расширенным функционалом валидации, маскирования и интеграции с темой приложения.

## Основные компоненты

### 1. AppTextController
Контроллер с расширенными возможностями:
- Валидация с debounce
- Маскирование ввода
- Управление состоянием поля
- Автоматическая навигация между полями

### 2. AppTextField
Виджет текстового поля с интеграцией темы и состояниями

## Как правильно использовать

### Базовое использование
```dart
// Создание контроллера
final _nameController = AppTextController(
  label: 'Имя',
  validator: (value) {
    if (value?.isEmpty ?? true) {
      return ValidatorResponse(FieldStateType.error, message: 'Обязательное поле');
    }
    return ValidatorResponse(FieldStateType.success);
  },
);

// Использование в виджете
AppTextField(
  controller: _nameController,
  keyboardType: TextInputType.text,
)
```

### Продвинутое использование

#### 1. Поле с маской (телефон)
```dart
final _phoneController = AppTextController(
  label: 'Телефон',
  mask: '+7 (###) ###-##-##',
  keyboardType: TextInputType.phone,
  validator: (value) {
    final unmasked = value?.replaceAll(RegExp(r'\D'), '') ?? '';
    if (unmasked.length != 11) {
      return ValidatorResponse(FieldStateType.error, message: 'Введите полный номер');
    }
    return ValidatorResponse(FieldStateType.success);
  },
);

AppTextField(
  controller: _phoneController,
  keyboardType: TextInputType.phone,
  icon: Icons.phone,
)
```

#### 2. Поле с паролем
```dart
final _passwordController = AppTextController(
  label: 'Пароль',
  obscure: true,
  maxLength: 20,
  validator: (value) {
    if ((value?.length ?? 0) < 6) {
      return ValidatorResponse(FieldStateType.error, message: 'Минимум 6 символов');
    }
    return ValidatorResponse(FieldStateType.success);
  },
);

AppTextField(
  controller: _passwordController,
  keyboardType: TextInputType.visiblePassword,
  maxLength: 20,
)
```

#### 3. Навигация между полями
```dart
final _emailController = AppTextController(label: 'Email');
final _passwordController = AppTextController(label: 'Пароль');

// В форме
Column(
  children: [
    AppTextField(
      controller: _emailController,
      nextFocusNode: _passwordController.focusNode,
      keyboardType: TextInputType.emailAddress,
    ),
    const SizedBox(height: 16),
    AppTextField(
      controller: _passwordController,
      obscure: true,
      textInputAction: TextInputAction.done,
    ),
  ],
)
```

#### 4. Динамическое управление состоянием
```dart
// Изменение состояния извне
void _validateField() {
  _nameController.updateFieldState(
    FieldStateType.error, 
    'Новое сообщение об ошибке'
  );
}

// Включение/выключение поля
void _toggleField() {
  _nameController.updateEnable(enable: false);
}

// Программный фокус
void _focusField() {
  _nameController.requestFocus();
}
```

#### 5. Кастомный форматтер
```dart
final _currencyController = AppTextController(
  label: 'Сумма',
  formatter: [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(10),
  ],
  validator: (value) {
    final amount = int.tryParse(value ?? '') ?? 0;
    if (amount < 100) {
      return ValidatorResponse(FieldStateType.error, message: 'Минимум 100');
    }
    return ValidatorResponse(FieldStateType.success);
  },
);
```

## Важные параметры AppTextField

### Обязательные
- `controller: AppTextController` - контроллер поля

### Опциональные
- `nextFocusNode: FocusNode?` - следующий узел фокуса
- `keyboardType: TextInputType` - тип клавиатуры
- `textInputAction: TextInputAction?` - действие кнопки
- `maxLines: int` - максимальное количество строк
- `minLines: int?` - минимальное количество строк
- `maxLength: int?` - максимальная длина текста
- `readOnly: bool` - режим только для чтения
- `initialFocus: bool` - автофокус при инициализации
- `canUnfocus: bool` - возможность снятия фокуса
- `icon: IconData?` - иконка слева
- `additionalText: String?` - дополнительный текст внизу
- `textAlign: TextAlign?` - выравнивание текста
- `onTap: VoidCallback?` - обработчик нажатия
- `onFieldSubmitted: ValueChanged<String>?` - обработчик отправки

## Важные параметры AppTextController

### Конструктор
- `text: String?` - начальный текст
- `label: String?` - метка поля
- `mask: String?` - маска ввода
- `enabled: bool` - активное состояние
- `fieldState: FieldStateType` - начальное состояние
- `validator: Function` - функция валидации
- `obscure: bool?` - скрыть текст (пароль)
- `debounceDuration: Duration` - задержка валидации
- `onUpdate: VoidCallback?` - callback при изменении
- `formatter: List<TextInputFormatter>?` - кастомные форматтеры

### Методы
- `requestFocus()` - установить фокус
- `updateFieldState(FieldStateType, String?)` - изменить состояние
- `updateEnable(bool)` - включить/выключить
- `initMask(mask, filter)` - инициализировать маску
- `updateMask(mask, filter)` - обновить маску
- `clearMask()` - очистить маску

### Свойства
- `masked` - текст с маской
- `unmasked` - текст без маски
- `focusNode` - узел фокуса
- `fieldState` - текущее состояние
- `enabled` - активное состояние

## Состояния поля (FieldStateType)

- `none` - обычное состояние
- `error` - ошибка (красная рамка)
- `success` - успех (зеленая рамка)
- `disable` - отключено
- `busy` - в процессе валидации

## Валидация

Валидация происходит автоматически с debounce задержкой:
```dart
validator: (value) async {
  // Асинхронная валидация
  await Future.delayed(Duration(milliseconds: 500));
  
  if (value?.isEmpty ?? true) {
    return ValidatorResponse(FieldStateType.error, message: 'Поле обязательно');
  }
  
  return ValidatorResponse(FieldStateType.success);
}
```

## Интеграция с темой

Виджет автоматически использует цвета темы:
- Основной цвет для фокуса
- Цвет ошибки для невалидного состояния
- Цвет успеха для валидного состояния
- Текстовые стили из темы

## Лучшие практики

1. **Всегда создавайте контроллеры с label** для лучшего UX
2. **Используйте debounce для асинхронной валидации**
3. **Настраивайте навигацию между полями** с помощью nextFocusNode
4. **Используйте маски** для форматированного ввода
5. **Обрабатывайте состояния** для визуальной обратной связи
6. **Очищайте ресурсы** контроллеров при dispose

## Частые сценарии

### Форма входа
```dart
final _emailController = AppTextController(
  label: 'Email',
  keyboardType: TextInputType.emailAddress,
  validator: _validateEmail,
);

final _passwordController = AppTextController(
  label: 'Пароль',
  obscure: true,
  validator: _validatePassword,
);
```

### Форма регистрации
```dart
final _nameController = AppTextController(label: 'Имя');
final _phoneController = AppTextController(
  label: 'Телефон',
  mask: '+7 (###) ###-##-##',
  keyboardType: TextInputType.phone,
);
final _emailController = AppTextController(
  label: 'Email',
  keyboardType: TextInputType.emailAddress,
);
```

### Поисковое поле
```dart
final _searchController = AppTextController(
  label: 'Поиск',
  debounceDuration: Duration(milliseconds: 300),
  onUpdate: () => _performSearch(_searchController.text),
);
```

## Чего следует избегать

1. **Не используйте стандартный TextField** - всегда используйте AppTextField
2. **Не забывайте про валидацию** - она встроена в систему
3. **Не игнорируйте состояния** - они важны для UX
4. **Не создавайте маски без необходимости** - они могут усложнить ввод
5. **Не устанавливайте слишком короткий debounce** - может вызвать лишние запросы



