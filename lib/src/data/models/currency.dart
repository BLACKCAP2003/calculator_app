class Currency {
  final int? id;
  final String? code;
  final String? ccy;
  final String? ccyNmRU;
  final String? ccyNmUZ;
  final String? ccyNmUZC;
  final String? ccyNmEN;
  final String? nominal;
  final String? rate;
  final String? diff;
  final String? date;

  Currency(
      {required this.id,
      required this.code,
      required this.ccy,
      required this.ccyNmRU,
      required this.ccyNmUZ,
      required this.ccyNmUZC,
      required this.ccyNmEN,
      required this.nominal,
      required this.rate,
      required this.diff,
      required this.date});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'],
      code: json['Code'],
      ccy: json['Ccy'],
      ccyNmRU: json['CcyNm_RU'],
      ccyNmUZ: json['CcyNm_UZ'],
      ccyNmUZC: json['CcyNm_UZC'],
      ccyNmEN: json['CcyNm_EN'],
      nominal: json['Nominal'],
      rate: json['Rate'],
      diff: json['Diff'],
      date: json['Date'],
    );
  }
}


//     "id": 69,
//     "Code": "840",
//     "Ccy": "USD",
//     "CcyNm_RU": "Доллар США",
//     "CcyNm_UZ": "AQSH dollari",
//     "CcyNm_UZC": "АҚШ доллари",
//     "CcyNm_EN": "US Dollar",
//     "Nominal": "1",
//     "Rate": "12837.10",
//     "Diff": "24.06",
//     "Date": "06.12.2024"
//   },
//