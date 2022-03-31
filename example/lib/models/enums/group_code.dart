enum GroupCode {
  CC,
  QRC,
  CSQR,
  THQR,
  SGQR,
  WEBPAY,
  CWALLET,
  EWALLET,
  BCTR,
  OTCTR,
  ATM,
  KIOSK,
  IBANK,
  BNPL,
  IPP,
  LIPP,
  GTPTY,
  LTPTY,
}

extension GroupCodeExtension on GroupCode {
  String get name {
    switch (this) {
      case GroupCode.CC:
        return 'CC';
      case GroupCode.QRC:
        return 'QRC';
      case GroupCode.CSQR:
        return 'CSQR';
      case GroupCode.THQR:
        return 'THQR';
      case GroupCode.SGQR:
        return 'SGQR';
      case GroupCode.WEBPAY:
        return 'WEBPAY';
      case GroupCode.CWALLET:
        return 'CWALLET';
      case GroupCode.EWALLET:
        return 'EWALLET';
      case GroupCode.BCTR:
        return 'BCTR';
      case GroupCode.OTCTR:
        return 'OTCTR';
      case GroupCode.ATM:
        return 'ATM';
      case GroupCode.KIOSK:
        return 'KIOSK';
      case GroupCode.IBANK:
        return 'IBANK';
      case GroupCode.BNPL:
        return 'BNPL';
      case GroupCode.IPP:
        return 'IPP';
      case GroupCode.LIPP:
        return 'LIPP';
      case GroupCode.GTPTY:
        return 'GTPTY';
      case GroupCode.LTPTY:
        return 'LTPTY';
    }
  }
}
