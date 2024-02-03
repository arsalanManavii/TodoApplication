

List<String> list() {
  var listResult = [
    'همه',
    '${replaceFarsiNumber('8')}:${replaceFarsiNumber('30')} - ${replaceFarsiNumber('10')}',
    '${replaceFarsiNumber('10')} - ${replaceFarsiNumber('12')}',
    '${replaceFarsiNumber('12')} - ${replaceFarsiNumber('13')}:${replaceFarsiNumber('30')}',
    '${replaceFarsiNumber('14')} - ${replaceFarsiNumber('16')}:${replaceFarsiNumber('20')}',
    '${replaceFarsiNumber('18')} - ${replaceFarsiNumber('19')}:${replaceFarsiNumber('30')}',
    '${replaceFarsiNumber('20')}:${replaceFarsiNumber('30')} - ${replaceFarsiNumber('21')}',
    '${replaceFarsiNumber('23')}:${replaceFarsiNumber('15')} - ${replaceFarsiNumber('00')}',
    '${replaceFarsiNumber('23')}:${replaceFarsiNumber('15')} - ${replaceFarsiNumber('00')}',
    '${replaceFarsiNumber('23')}:${replaceFarsiNumber('15')} - ${replaceFarsiNumber('00')}',
    '${replaceFarsiNumber('23')}:${replaceFarsiNumber('15')} - ${replaceFarsiNumber('00')}',
  ];

  return listResult;
}

String replaceFarsiNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], farsi[i]);
  }

  return input;
}
