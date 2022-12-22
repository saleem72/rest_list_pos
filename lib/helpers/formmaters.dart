//

import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  static final NumberFormat numberFormater = NumberFormat('#,##0.##');
  static final NumberFormat currencyFormater = NumberFormat('#,##0.## SP');
  // 13/12/2022 - 12:15 PM
  // static final DateFormat dateFormatter = DateFormat.yMd().add_jm();
  static final DateFormat dateFormatter = DateFormat('d/M/yyyy - h:m');
  static final DateFormat datePresenter = DateFormat('d MMM yyyy');
  static final DateFormat timePresenter = DateFormat.jm(); //('h:m');

  static DateTime dateFrom(String str) {
    try {
      final temp = dateFormatter.parse(str);
      return temp;
    } on Exception {
      final date = DateTime.now();
      print(dateFormatter.format(date));
      return date;
    }
  }
}
