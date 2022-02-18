class Validator {
  Validator._();

  static String? validEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);

    if (value!.isEmpty)
      return '*Email Required';
    else if (!regex.hasMatch(value))
      return '*Email Invalid.';
    else
      return null;
  }

  static String? validMobileNo(String? value) {
    String pattern = r'^[0-9]{10}$';
    RegExp regex = RegExp(pattern);

    if (value!.isEmpty)
      return '*Mobile Number Required';
    else if (!regex.hasMatch(value))
      return '*Mobile Number Invalid.';
    else
      return null;
  }

  static String? validName(String? value) {
    String pattern = r'^[A-Za-z]+$';
    RegExp regex = RegExp(pattern);

    if (value!.isEmpty)
      return '*Name required';
    else if (!regex.hasMatch(value))
      return '*Name Invalid.';
    else
      return null;
  }

  static String? validDropdownCountry(String? value) {
    if (value == null) return '*Country required';
    return null;
  }

  static String? validDropdownAgent(String? value) {
    if (value == null) return '*Payment agent required';
    return null;
  }
}
