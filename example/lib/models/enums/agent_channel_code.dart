enum AgentChannelCode {
  WEBPAY,
  BANKCOUNTER,
  OVERTHECOUNTER,
  ATM,
  KIOSK,
  IBANKING,
}

extension AgentChannelCodeExtension on AgentChannelCode {
  String get name {
    switch (this) {
      case AgentChannelCode.WEBPAY:
        return 'WEBPAY';
      case AgentChannelCode.BANKCOUNTER:
        return 'BABANKCOUNTER';
      case AgentChannelCode.OVERTHECOUNTER:
        return 'OOVERTHECOUNTER';
      case AgentChannelCode.ATM:
        return 'ATM';
      case AgentChannelCode.KIOSK:
        return 'KIOSK';
      case AgentChannelCode.IBANKING:
        return 'IBANKING';
    }
  }
}
