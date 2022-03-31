import 'package:pgw_sdk_example/models/enums/group_code.dart';

enum CategoryCode {
  GCARD,
  QR,
  WEBPAY,
  DPAY,
  COUNTER,
  SSM,
  IMBANK,
  GBNPL,
  LCARDIPP,
  LCARD,
}

extension CategoryCodeExtension on CategoryCode {
  String get name {
    switch (this) {
      case CategoryCode.GCARD:
        return 'GCARD';
      case CategoryCode.QR:
        return 'QR';
      case CategoryCode.WEBPAY:
        return 'WEBPAY';
      case CategoryCode.DPAY:
        return 'DPAY';
      case CategoryCode.COUNTER:
        return 'COUNTER';
      case CategoryCode.SSM:
        return 'SSM';
      case CategoryCode.IMBANK:
        return 'IMBANK';
      case CategoryCode.GBNPL:
        return 'GBNPL';
      case CategoryCode.LCARDIPP:
        return 'LCARDIPP';
      case CategoryCode.LCARD:
        return 'LCARD';
    }
  }

  List<GroupCode> get availableGroupCodes {
    switch (this) {
      case CategoryCode.GCARD:
        return [GroupCode.CC, GroupCode.IPP, GroupCode.GTPTY];
      case CategoryCode.QR:
        return [GroupCode.QRC, GroupCode.CSQR, GroupCode.THQR, GroupCode.SGQR];
      case CategoryCode.WEBPAY:
        return [GroupCode.WEBPAY];
      case CategoryCode.DPAY:
        return [GroupCode.EWALLET];
      case CategoryCode.COUNTER:
        return [GroupCode.BCTR, GroupCode.OTCTR];
      case CategoryCode.SSM:
        return [GroupCode.ATM, GroupCode.KIOSK];
      case CategoryCode.IMBANK:
        return [GroupCode.IBANK];
      case CategoryCode.GBNPL:
        return [GroupCode.BNPL];
      case CategoryCode.LCARDIPP:
        return [GroupCode.LIPP];
      case CategoryCode.LCARD:
        return [GroupCode.LTPTY];
    }
  }
}
