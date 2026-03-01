# 🧮 DeltaOS Calculator - Современный калькулятор для DeltaOS

<div align="center">

[![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0%2B-0175C2.svg)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-DeltaOS%20%7C%20Linux%20%7C%20Android-9cf.svg)](https://github.com/yourusername/calculator)
[![Status](https://img.shields.io/badge/Status-Active-brightgreen)](https://github.com/yourusername/calculator)

</div>

<div align="left">
╔═══════════════════════════════════════╗<br>
║                                       ║<br>
║   ╔═╗ ╔═╗ ╦  ╔═╗ ╔═╗ ╔═╗ ╔═╗ ╔╦╗      ║<br>
║   ║╣  ╠═╣ ║  ╠═╝ ╠═╣ ║ ╦ ║╣   ║       ║<br>
║   ╚═╝ ╩ ╩ ╩═╝╩   ╩ ╩ ╚═╝ ╚═╝  ╩       ║<br>
║                                       ║<br>
║      C A L C U L A T O R              ║<br>
║              f o r    D e l t a O S   ║<br>
╚═══════════════════════════════════════╝<br>
</div>

<div align="center">

**DeltaOS Calculator** — это стильный и функциональный калькулятор с тёмной темой в фирменных цветах DeltaOS. Поддерживает базовые и инженерные вычисления с удобным интерфейсом!

</div>

---

## 🎯 Для кого этот проект?

- **Для пользователей DeltaOS** — нативный калькулятор в стиле системы.
- **Для новичков** — простой и понятный интерфейс.
- **Для разработчиков** — пример Flutter-приложения с кастомной темой.
- **Для студентов** — изучение Flutter и математических операций.

---

## ✨ Возможности

| Категория | Функционал |
|-----------|-----------|
| **🔢 Базовые операции** | Сложение `+`, вычитание `-`, умножение `×`, деление `÷` |
| **📐 Инженерные функции** | Скобки `(` `)`, корень `√`, степень `^`, смена знака `+/-` |
| **🧹 Управление** | Очистка `CE`, удаление символа `⌫` |
| **🎨 Интерфейс** | Тёмная тема в цветах DeltaOS, адаптивный layout |
| **💻 Платформы** | DeltaOS, Linux, Android, Web |

---

## 🚀 Быстрый старт

### Требования

- **Flutter SDK** 3.0 или новее
- **Dart** 3.0 или новее

### Установка

```bash
# 1. Клонируйте репозиторий
git clone https://github.com/yourusername/calculator.git

# 2. Перейдите в папку проекта
cd calculator

# 3. Установите зависимости
flutter pub get

# 4. Запустите приложение
flutter run
```

### Сборка
```bash
# Linux (DeltaOS)
flutter build linux --release

# Android APK
flutter build apk --release

# Web
flutter build web --release
```

### 🎨 Интерфейс


### Цветовая схема DeltaOS

| Элемент         | Цвет      | Описание                      |
| --------------- | --------- | ----------------------------- |
| Фон             | `#1a1b26` | Тёмный фон приложения         |
| Кнопки цифр     | `#24283b` | Тёмно-синие цифровые кнопки   |
| Кнопки операций | `#7dcfff` | Голубые функциональные кнопки |
| Кнопка равно    | `#7dcfff` | Акцентная кнопка результата   |
| Текст           | `#a9b1d6` | Светло-фиолетовый текст       |

### 📚 Структура проекта

calculator/
├── lib/
│   ├── main.dart                 # Точка входа
│   ├── app.dart                  # Корневой виджет с темой
│   ├── constants/
│   │   ├── colors.dart           # Цвета DeltaOS
│   │   └── theme.dart            # Тема приложения
│   ├── models/
│   │   └── calculator_model.dart # Логика вычислений
│   ├── providers/
│   │   └── calculator_provider.dart # State management
│   ├── screens/
│   │   └── home_screen.dart      # Главный экран
│   └── widgets/
│       ├── calculator_button.dart    # Кнопка калькулятора
│       ├── keypad.dart               # Панель кнопок
│       └── display.dart              # Дисплей результата
├── test/                         # Тесты
└── pubspec.yaml                  # Зависимости

### 💡 Полезные советы

- Скобки: Используйте ( и ) для сложных выражений: (2+3)×4
- Степень: Кнопка ^ для возведения в степень: 2^3 = 8
- Корень: Кнопка √ для квадратного корня: √16 = 4
- Смена знака: +/- меняет знак числа: 5 → -5
- Очистка: CE сбрасывает текущий ввод, ⌫ удаляет последний символ

### 🔧 Технические детали

- Фреймворк: Flutter 3.0+
- Язык: Dart 3.0+
- Архитектура: Provider / ChangeNotifier
- Тема: Кастомная тёмная тема DeltaOS
- Зависимости:
    - math_expressions — парсинг и вычисление формул
    - provider — управление состоянием

### 🤝 Вклад в проект

## Мы приветствуем ваш вклад! Хотите улучшить Calculator DeltaOS?

1.  **Форкните** репозиторий.
2.  Создайте **новую ветку** (`git checkout -b feature/AmazingFeature`).
3.  **Внесите изменения** и сделайте коммит (`git commit -m 'Add some AmazingFeature'`).
4.  **Запушьте** ветку (`git push origin feature/AmazingFeature`).
5.  Откройте **Pull Request**.

## Идеи для улучшения
[ ] История вычислений (свайп вверх)
[ ] Настройки точности десятичных знаков
[ ] Звуковой feedback при нажатии
[ ] Поддержка горячих клавиш (Desktop)
[ ] Экспорт истории в файл

---

## 📝 Лицензия

Этот проект распространяется под лицензией [MIT](https://opensource.org/licenses/MIT).

---

<div align="center">
🎉 Наслаждайтесь вычислениями!
DeltaOS Calculator — точность и стиль в каждой операции!
</div>

<div align="center">
Помните: Дважды проверяйте расчёты перед важными решениями! 🧮
</div>
```
