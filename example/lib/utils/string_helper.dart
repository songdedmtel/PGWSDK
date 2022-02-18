import 'dart:math';

class StringHelper {
  static String generateInvoiceNo() {
    final len = 11;
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(10));
    return values.join();
  }
}
