class CalculatorService {
  static bool isOperator(String symbol) =>
      symbol == '+' || symbol == '-' || symbol == '*' || symbol == '/';

  static bool isNumber(String letter) =>
      letter == '0' ||
      letter == '1' ||
      letter == '2' ||
      letter == '3' ||
      letter == '4' ||
      letter == '5' ||
      letter == '6' ||
      letter == '7' ||
      letter == '8' ||
      letter == '9';

  static num performOperation(String operator, num a, num b) {
    switch (operator) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '*':
        return a * b;
      case '/':
        return a / b;
      default:
        throw Exception('Unknown operator: $operator');
    }
  }

  List<String> tokenize(String input) {
    List<String> tokens = [];
    String temp = '';

    for (int i = 0; i < input.length; i++) {
      String current = input[i];

      if (current == '(' || current == ')') {
        if (temp.isNotEmpty) {
          tokens.add(temp);
          temp = '';
        }
        tokens.add(current);
      } else if (isOperator(current)) {
        if (current == '-' &&
            (i == 0 || isOperator(input[i - 1]) || input[i - 1] == '(')) {
          temp += current;
        } else {
          if (temp.isNotEmpty) {
            tokens.add(temp);
            temp = '';
          }
          tokens.add(current);
        }
      } else {
        temp += current;
      }
    }

    if (temp.isNotEmpty) tokens.add(temp);

    return tokens.map((e) => e.trim()).toList();
  }

  String calculate(String input) {
    List<String> tokens = tokenize(input);

    while (tokens.contains('(')) {
      int openIndex = tokens.lastIndexOf('(');
      int closeIndex = tokens.indexOf(')', openIndex);

      if (closeIndex == -1) {
        throw Exception("Error: unbalanced parentheses");
      }

      List<String> subExpression = tokens.sublist(openIndex + 1, closeIndex);
      String result = _evaluate(subExpression).toString();

      tokens.replaceRange(openIndex, closeIndex + 1, [result]);
    }

    return _evaluate(tokens).toString();
  }

  num _evaluate(List<String> tokens) {
    List<String> operators = ['*', '/', '+', '-'];

    for (String operator in operators) {
      while (tokens.contains(operator)) {
        int index = tokens.indexOf(operator);

        num a = num.parse(tokens[index - 1]);
        num b = num.parse(tokens[index + 1]);
        num result = performOperation(operator, a, b);

        tokens.replaceRange(index - 1, index + 2, [result.toString()]);
      }
    }

    return num.parse(tokens.first);
  }

  String getFormatInput(String input, String add) {
    String res = '';
    if (input.isNotEmpty) {
      if (add == "()") {
        String last = input.split('').last;

        if (isOperator(last)) {
          res = '$input(';
        } else {
          res = '$input)';
        }
      }
    } else {
      res = '$input$add';
    }
    return res;
  }
}
