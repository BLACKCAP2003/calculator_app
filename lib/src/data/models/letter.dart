enum LetterType { letter, symbol, special }

class Letter {
  String letter;
  LetterType letterType;

  Letter({required this.letter, required this.letterType});

  static String getAsset(String letter) {
    switch (letter) {
      case '()':
        return 'assets/icons/brackets.svg';
      case '+/-':
        return 'assets/icons/plus-minus.svg';

      case '%':
        return 'assets/icons/percent.svg';

      case '/':
        return 'assets/icons/divide.svg';

      case '*':
        return 'assets/icons/multiply.svg';

      case '-':
        return 'assets/icons/subtract.svg';

      case '+':
        return 'assets/icons/add.svg';

      case '=':
        return 'assets/icons/equal.svg';

      case 'reload':
        return 'assets/icons/reload.svg';

      default:
        return letter;
    }
  }

  static List<List<Letter>> letters = [
    [
      Letter(letter: 'AC', letterType: LetterType.letter),
      Letter(letter: '()', letterType: LetterType.special),
      Letter(letter: '%', letterType: LetterType.special),
      Letter(letter: '/', letterType: LetterType.symbol),
    ],
    [
      Letter(letter: '7', letterType: LetterType.letter),
      Letter(letter: '8', letterType: LetterType.letter),
      Letter(letter: '9', letterType: LetterType.letter),
      Letter(letter: '*', letterType: LetterType.symbol),
    ],
    [
      Letter(letter: '4', letterType: LetterType.letter),
      Letter(letter: '5', letterType: LetterType.letter),
      Letter(letter: '6', letterType: LetterType.letter),
      Letter(letter: '-', letterType: LetterType.symbol),
    ],
    [
      Letter(letter: '1', letterType: LetterType.letter),
      Letter(letter: '2', letterType: LetterType.letter),
      Letter(letter: '3', letterType: LetterType.letter),
      Letter(letter: '+', letterType: LetterType.symbol),
    ],
    [
      Letter(letter: 'reload', letterType: LetterType.special),
      Letter(letter: '0', letterType: LetterType.letter),
      Letter(letter: '.', letterType: LetterType.letter),
      Letter(letter: '=', letterType: LetterType.symbol),
    ]
  ];

  static List<String> numbers = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];

  static bool isNumber(String letter) => numbers.contains(letter);
}
