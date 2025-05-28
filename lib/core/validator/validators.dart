class CustomValidator {
  static String? phoneValidator({required String value}) {
    //number validator regex
    // RegExp regExp = RegExp(r'^[0-9]+$');
    RegExp regExp = RegExp(r'^[6-9][0-9]{9}$');

    if (value.isEmpty || value.length > 10 || value.length < 10) {
      return "Invalid phone number";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid phone number";
    } else {
      return null;
    }
  }

  //email
  static String? emailValidator({required String value}) {
    //number validator regex
    // RegExp regExp = RegExp(r'^[0-9]+$');
    RegExp validationLimitForEmail =
        RegExp(r'^(?!.*\s).+@[a-zA-Z]+\.[a-zA-Z]+(\.?[a-zA-Z]+)$');

    if (!validationLimitForEmail.hasMatch(value)) {
      return "Email should be a valid email.";
    } else {
      return null;
    }
  }
}
