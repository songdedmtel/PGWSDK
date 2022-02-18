enum CountryCode {
  GLOBAL,
  TH,
  MM,
  PH,
  SG,
  MY,
  ID,
  HK,
  VN,
  KR,
  AU,
  UK,
  KH,
  KZ,
  IN,
}

extension CountryCodeExtension on CountryCode {
  String get name {
    switch (this) {
      case CountryCode.TH:
        return 'Thailand';
      case CountryCode.MM:
        return 'Myanmar';
      case CountryCode.PH:
        return 'Phillipines';
      case CountryCode.SG:
        return 'Singapore';
      case CountryCode.MY:
        return 'Malaysia';
      case CountryCode.ID:
        return 'Indonesia';
      case CountryCode.HK:
        return 'Hong Kong';
      case CountryCode.VN:
        return 'Vietnam';
      case CountryCode.KR:
        return 'Korea';
      case CountryCode.AU:
        return 'Australia';
      case CountryCode.UK:
        return 'United Kingdom';
      case CountryCode.KH:
        return 'Cambodia';
      case CountryCode.KZ:
        return 'Kyrgyzstan';
      case CountryCode.IN:
        return 'India';
      case CountryCode.GLOBAL:
        return 'Global';
      default:
        return '';
    }
  }

  String get merchantId {
    switch (this) {
      case CountryCode.SG:
        return 'JT01';
      case CountryCode.MM:
        return 'JT02';
      case CountryCode.ID:
        return 'JT03';
      case CountryCode.TH:
        return 'JT04';
      case CountryCode.PH:
        return 'JT05';
      case CountryCode.HK:
        return 'JT06';
      case CountryCode.MY:
        return 'JT07';
      case CountryCode.VN:
        return 'JT08';
      default:
        return '';
    }
  }

  String get currencyCode {
    switch (this) {
      case CountryCode.SG:
        return 'SGD';
      case CountryCode.MM:
        return 'MMK';
      case CountryCode.ID:
        return 'IDR';
      case CountryCode.TH:
        return 'THB';
      case CountryCode.PH:
        return 'PHP';
      case CountryCode.HK:
        return 'HKD';
      case CountryCode.MY:
        return 'MYR';
      case CountryCode.VN:
        return 'VND';
      default:
        return '';
    }
  }

  String get currencyNumber {
    switch (this) {
      case CountryCode.SG:
        return '702';
      case CountryCode.MM:
        return '104';
      case CountryCode.ID:
        return '360';
      case CountryCode.TH:
        return '764';
      case CountryCode.PH:
        return '608';
      case CountryCode.HK:
        return '344';
      case CountryCode.MY:
        return '458';
      case CountryCode.VN:
        return '704';
      default:
        return '';
    }
  }

  String get merchantSecretKey {
    switch (this) {
      case CountryCode.SG:
        return 'ECC4E54DBA738857B84A7EBC6B5DC7187B8DA68750E88AB53AAA41F548D6F2D9';
      case CountryCode.MM:
        return '72B8F060B3B923E580411200068A764610F61034AE729AB9EF20CAFF93AFA1B9';
      case CountryCode.ID:
        return '27987D9549844E0B4F5F4DCA69FEB716FAA5F095513F6F619FBDC8E865471DE7';
      case CountryCode.TH:
        return 'CD229682D3297390B9F66FF4020B758F4A5E625AF4992E5D75D311D6458B38E2';
      case CountryCode.PH:
        return '71138119281833EB4608E461EEB5E4BDE7D17EB9DC5413A21DCBD593109162C6';
      case CountryCode.HK:
        return '61E900D6D1AA15A8050A4C405D001EBBF432CFCDB06B7915451E5F27C8CC2C35';
      case CountryCode.MY:
        return '9E936798778E8E21ABA8E7B620EF631E0C957BB1ADA14E4960022307A9726A09';
      case CountryCode.VN:
        return '68CD359273E58B32DEF38E2BD7013BBB8450E82A01A122614690330D8D560642';
      default:
        return '';
    }
  }
}
