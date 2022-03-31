enum SDKAPIType {
  paymentOptions,
  paymentOptionDetails,
  doPayment,
  transactionStatusInquiry,
  pgwInitialization,
  cardTokensInformation,
  exchangeRate,
  userPreference,
  paymentNotification,
  cancelTransaction,
}

extension SDKAPITypeExtension on SDKAPIType {
  String get name {
    switch (this) {
      case SDKAPIType.paymentOptions:
        return 'Payment Options';
      case SDKAPIType.paymentOptionDetails:
        return 'Payment Option Details';
      case SDKAPIType.doPayment:
        return 'Do Payment';
      case SDKAPIType.transactionStatusInquiry:
        return 'Transaction Status Inquiry';
      case SDKAPIType.pgwInitialization:
        return 'PGW Initialization';
      case SDKAPIType.cardTokensInformation:
        return 'Card Tokens Information';
      case SDKAPIType.exchangeRate:
        return 'Exchange Rate';
      case SDKAPIType.userPreference:
        return 'User Preference';
      case SDKAPIType.paymentNotification:
        return 'Payment Notification';
      case SDKAPIType.cancelTransaction:
        return 'Cancel Transaction';
    }
  }
}
