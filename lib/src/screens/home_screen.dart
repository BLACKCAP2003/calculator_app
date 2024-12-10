import 'package:calculator_app/src/data/models/expression.dart';
import 'package:calculator_app/src/data/models/letter.dart';
import 'package:calculator_app/src/services/calculator_service.dart';
import 'package:calculator_app/src/utils/constants/colors.dart';
import 'package:calculator_app/src/utils/constants/styles.dart';
import 'package:calculator_app/src/widgets/buttons_widget.dart';
import 'package:calculator_app/src/widgets/number_list_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String expression = '';
  String result = '';

  List<Expression> expressions = [];

  int selectedTabIndex = 0;

  List<String> tabs = ['Calculator', 'Converter'];
  void calculate() {
    try {
      if (expression.isEmpty) {
        setState(() {
          result = '';
        });
      }

      final calculator = CalculatorService();
      final _result = calculator.calculate(expression);

      setState(() {
        result = _result;
      });
    } catch (e) {
      setState(() {
        result = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            buildHeaderButtons(),
            buildOnboard(context),
            buildKeyboard(),
          ],
        ),
      ),
    );
  }

  Flexible buildKeyboard() {
    return Flexible(
      flex: 5,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.08),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            )),
        child: Column(
          children: Letter.letters
              .map(
                (row) => Expanded(
                  child: Row(
                    children: row.map(
                      (letter) {
                        if (letter.letterType == LetterType.special) {
                          return ButtonsWidget(
                            title: Letter.getAsset(letter.letter),
                            color: letter.letter == 'reload'
                                ? AppColors.black
                                : AppColors.green,
                            onTap: () {
                              if (letter.letter == 'reload') {}
                              setState(() {
                                expression = CalculatorService()
                                    .getFormatInput(expression, letter.letter);
                                calculate();
                              });
                            },
                          );
                        } else if (letter.letterType == LetterType.symbol) {
                          return ButtonsWidget(
                            title: letter.letter,
                            color: AppColors.red,
                            onTap: () {
                              if (letter.letter == '=') {
                                setState(() {
                                  expressions.add(
                                    Expression(
                                        text: expression,
                                        result: result,
                                        createAt: DateTime.now()),
                                  );

                                  expression = result;
                                  result = '';
                                  calculate();
                                });
                              } else {
                                setState(() {
                                  expression += letter.letter;
                                  calculate();
                                });
                              }
                            },
                          );
                        }
                        return NumberWidget(
                          title: letter.letter,
                          color: letter.letter == 'AC'
                              ? AppColors.green
                              : AppColors.black,
                          onTap: () {
                            if (letter.letter == 'AC') {
                              if (expression.isNotEmpty) {
                                setState(() {
                                  expression = expression.substring(
                                      0, expression.length - 1);
                                });
                                calculate();
                              }
                            } else {
                              setState(() {
                                expression += letter.letter;
                                calculate();
                              });
                            }
                          },
                        );
                      },
                    ).toList(),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Flexible buildOnboard(BuildContext context) {
    return Flexible(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              flex: 3,
              child: ListView.builder(
                itemCount: expressions.length,
                itemBuilder: (context, index) {
                  var expression = expressions[index];
                  return Text(
                    '${expression.text} = ${expression.result}',
                    textAlign: TextAlign.right,
                    style: AppStyles.historyStyle(context),
                  );
                },
              ),
            ),
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      children: expression
                          .split('')
                          .map(
                            (e) => TextSpan(
                              text: CalculatorService.isOperator(e)
                                  ? '\t$e\t'
                                  : e,
                              style: AppStyles().titleStyle(e, context),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Text(
                    '= $result',
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: MediaQuery.of(context).devicePixelRatio * 9),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeaderButtons() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: tabs
              .map((e) => Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTabIndex = tabs.indexOf(e);
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              e,
                              style: TextStyle(
                                  color: selectedTabIndex == tabs.indexOf(e)
                                      ? AppColors.black
                                      : AppColors.grey),
                            ),
                            selectedTabIndex == tabs.indexOf(e)
                                ? AnimatedContainer(
                                    height: 2,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: AppColors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    curve: Curves.linearToEaseOut,
                                    duration: Duration(milliseconds: 300),
                                    margin: EdgeInsets.only(top: 4),
                                  )
                                : SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
