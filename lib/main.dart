import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart' as window_size;

const Map<String, Map<String, Color>> themeConfig = {
  "dark": {
    "accent": Color(0xFF52C9DC),
    "primary": Color(0xFF1A1B28),
    "second": Color(0xFF1E2435),
    "font": Color(0xFFFFFFFF),
  },
  "light": {
    "accent": Color(0xFF52C9DC),
    "primary": Color(0xFFFFFFFF),
    "second": Color(0xFFF2F8FC),
    "font": Color(0xFF454545),
  },
};

const List<List<String>> buttons = [
  ["CE", "(", ")", "⌫"],
  ["+/-", "√", "^", "+"],
  ["7", "8", "9", "-"],
  ["4", "5", "6", "x"],
  ["1", "2", '3', "/"],
  ["0", ".", "="]
];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const Size windowSize = Size(400, 700);

  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    window_size.setWindowTitle('DeltaOS Calculator');
    window_size.setWindowMinSize(windowSize);
    window_size.setWindowMaxSize(windowSize);

    final screen = await window_size.getCurrentScreen();
    if (screen != null) {
      final screenFrame = screen.frame;
      final left =
          screenFrame.left + (screenFrame.width - windowSize.width) / 2;
      final top =
          screenFrame.top + (screenFrame.height - windowSize.height) / 2;
      window_size.setWindowFrame(
        Rect.fromLTWH(left, top, windowSize.width, windowSize.height),
      );
    }
  }

  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.light,
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
    ),
    themeMode: ThemeMode.system,
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String stringInput = "";
  double resultOutput = 0.0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cfg = themeConfig[isDark ? "dark" : "light"]!;

    final color_primary = cfg["primary"]!;
    final color_accent = cfg["accent"]!;
    final color_second = cfg["second"]!;
    final color_font = cfg["font"]!;

    return Material(
      color: color_primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: math.max(0, MediaQuery.sizeOf(context).width - 20),
            height: math.max(
                0, (MediaQuery.sizeOf(context).height / 100) * 15 - 10),
            decoration: BoxDecoration(
              color: color_primary,
              border: Border(bottom: BorderSide(color: color_accent)),
            ),
            padding: EdgeInsets.only(bottom: 10),
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                // Знак "=" фиксированной ширины
                SizedBox(
                  width: 50, // Фиксированная ширина для "="
                  child: Text(
                    "=",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 40, color: color_accent),
                  ),
                ),
                // Результат занимает ВСЁ оставшееся пространство
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: SelectableText(
                      resultOutput == 0.0
                          ? ""
                          : formatNumber(resultOutput)['display']!,
                      textAlign:
                          TextAlign.right, // Выравнивание по правому краю
                      style: TextStyle(
                        fontSize: 40,
                        color: color_font,
                        fontWeight: FontWeight.w900,
                      ),
                      enableInteractiveSelection: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: math.max(0, MediaQuery.sizeOf(context).width - 20),
            height: math.max(
                0, (MediaQuery.sizeOf(context).height / 100) * 15 - 20),
            margin: EdgeInsets.only(bottom: 10, top: 10),
            decoration: BoxDecoration(
              color: color_primary,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.only(bottom: 10),
            alignment: Alignment.bottomRight,
            child: buildColoredInput(stringInput, color_font, color_accent),
          ),
          Container(
            width: math.max(0, MediaQuery.sizeOf(context).width - 20),
            height: math.max(
                0, (MediaQuery.sizeOf(context).height / 100) * 70 - 10),
            decoration: BoxDecoration(
              color: color_second,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                for (final row in buttons)
                  Expanded(
                    child: Row(
                      children: [
                        for (final label in row)
                          Expanded(
                            flex: label == "=" ? 2 : 1,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        double.tryParse(label) != null ||
                                                label == '.'
                                            ? color_primary
                                            : color_accent,
                                    foregroundColor:
                                        double.tryParse(label) != null ||
                                                label == '.'
                                            ? color_font
                                            : themeConfig['dark']!['font']!,
                                    minimumSize: const Size(80, 80),
                                    padding: const EdgeInsets.all(8),
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                      color: color_font,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (label == "CE") {
                                        stringInput = "";
                                        resultOutput = 0.0;
                                      } else if (label == '+/-') {
                                        if (stringInput.startsWith('-')) {
                                          stringInput =
                                              stringInput.substring((1));
                                        } else {
                                          stringInput = '-$stringInput';
                                        }
                                      } else if (label == "⌫") {
                                        if (stringInput.isNotEmpty) {
                                          stringInput = stringInput.substring(
                                              0, stringInput.length - 1);
                                        }
                                      } else if (label == "=") {
                                        resultOutput = eval(stringInput);
                                      } else {
                                        stringInput += label;
                                      }
                                    });
                                  },
                                  child: Text(label)),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Map<String, String> formatNumber(double value) {
  // 1. Обрабатываем специальные значения
  if (value.isInfinite) {
    return {'display': '∞', 'copy': 'Infinity'};
  }
  if (value.isNaN) {
    return {'display': 'Ошибка', 'copy': 'NaN'};
  }

  // 2. Абсолютное значение для проверки диапазона
  final absValue = value.abs();

  // 3. Если число очень большое или очень маленькое → экспонента
  if (absValue >= 1e10 || (absValue < 1e-6 && absValue > 0)) {
    final expString = value.toStringAsExponential(6);
    final cleaned = expString.replaceFirst(RegExp(r'\.?0+e'), 'e');
    return {'display': cleaned, 'copy': value.toString()};
  }

  // 4. Обычные числа: убираем лишние нули после запятой
  final fixed = value.toStringAsFixed(10).replaceFirst(RegExp(r'\.?0+$'), '');
  return {'display': fixed, 'copy': fixed};
}

Widget buildColoredInput(String input, Color fontColor, Color accentColor) {
  if (input.isEmpty) {
    return SelectableText(
      "0.0",
      textAlign: TextAlign.right,
      style: TextStyle(
        fontSize: 20,
        color: fontColor,
      ),
    );
  }

  final spans = <TextSpan>[];
  const operators = '+-*/%^)(x';

  for (int i = 0; i < input.length; i++) {
    final char = input[i];
    final isOperator = operators.contains(char);

    spans.add(
      TextSpan(
        text: char,
        style: TextStyle(
          fontSize: 20,
          color: isOperator ? accentColor : fontColor,
          fontWeight: isOperator ? FontWeight.w700 : FontWeight.normal,
        ),
      ),
    );
  }

  return SelectableText.rich(
    TextSpan(children: spans),
    textAlign: TextAlign.right,
    style: TextStyle(
      fontSize: 20,
      color: fontColor,
    ),
  );
}

double eval(String args) {
  args = args.replaceAll(' ', '');
  args = args.replaceAll('x', '*');

  final values = <double>[];
  final ops = <String>[];

  int prec(String op) {
    switch (op) {
      case '^':
      case '√':
        return 3;
      case '*':
      case '/':
        return 2;
      case '+':
      case '-':
        return 1;
      default:
        return 0;
    }
  }

  bool isUnary(String op) => op == '√';
  bool isRightAssoc(String op) => op == '^';

  void applyOp() {
    if (ops.isEmpty) {
      throw FormatException("Внутренняя ошибка: нет операций для применения");
    }

    final op = ops.removeLast();

    if (isUnary(op)) {
      if (values.isEmpty) {
        throw FormatException("Недостаточно чисел для операции '$op'");
      }

      final a = values.removeLast();

      switch (op) {
        case "√":
          if (a < 0) throw FormatException("Корень из отрицательного числа!");
          values.add(math.sqrt(a));
          break;
      }
      return;
    }

    if (values.length < 2) {
      throw FormatException("Недостаточно чисел для вычисления");
    }

    final b = values.removeLast();
    final a = values.removeLast();

    switch (op) {
      case '+':
        values.add(a + b);
        break;
      case '-':
        values.add(a - b);
        break;
      case '*':
        values.add(a * b);
        break;
      case '/':
        values.add(a / b);
        break;
      case '^':
        values.add(math.pow(a, b).toDouble());
        break;
      default:
        throw FormatException("Неизвестный оператор '$op'");
    }
  }

  bool isDigit(String ch) => RegExp(r'[0-9.]').hasMatch(ch);

  int i = 0;
  while (i < args.length) {
    final ch = args[i];

    if (isDigit(ch)) {
      final buffer = StringBuffer();
      while (i < args.length && isDigit(args[i])) {
        buffer.write(args[i]);
        i++;
      }
      values.add(double.parse(buffer.toString()));
      continue;
    }

    if (ch == '(') {
      ops.add(ch);

      if (i + 1 < args.length && args[i + 1] == '√') {
        ops.add('√');
        i++;
      }
    } else if (ch == ')') {
      while (ops.isNotEmpty && ops.last != '(') {
        applyOp();
      }
      if (ops.isNotEmpty && ops.last == '(') {
        ops.removeLast();
      }
    } else if (ch == '-' && (i == 0 || '+-*/√^('.contains(args[i - 1]))) {
      i++;
      final buffer = StringBuffer()..write('-');
      while (i < args.length && isDigit(args[i])) {
        buffer.write(args[i]);
        i++;
      }
      values.add(double.parse(buffer.toString()));
      continue;
    } else if (ch == '√') {
      ops.add('√');
    } else if ('+-*/^'.contains(ch)) {
      while (ops.isNotEmpty &&
          ops.last != '(' &&
          (prec(ops.last) > prec(ch) ||
              (prec(ops.last) == prec(ch) && !isRightAssoc(ch)))) {
        applyOp();
      }
      ops.add(ch);
    }

    i++;
  }

  while (ops.isNotEmpty) {
    applyOp();
  }

  return values.single;
}
