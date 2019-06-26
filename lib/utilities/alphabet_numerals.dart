class AlphabetNumberals {
  static int letterToNumber(String columnName) {
    columnName = columnName.toUpperCase();

    int sum = 0;

    for (int i = 0; i < columnName.length; i++) {
      sum *= 26;
      sum += (columnName[i].codeUnits.first - 'A'.codeUnits.first + 1);
    }

    return sum;
  }

  static String numberToLetter(int n) {
    String title = "";
    while (n > 0) {
      int mod = (n - 1) % 26;
      n = (n - mod) ~/ 26;

      title = "${String.fromCharCode(mod + 65)}$title";
    }

    return title;
  }
}
