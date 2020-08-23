class Validator {
  String validateName(String value) {
    Pattern pattern = r'^[a-zA-Z]{3,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Name should contain letters only';
    else if (value.length < 3)
      return 'Name must have atleat 3 letters';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return null;
    } else {
      if (!regex.hasMatch(value))
        return 'Enter valid Email or leave it empty';
      else
        return null;
    }
  }

  String validateNumber(String value) {
    Pattern pattern = r'^[6-9]\d{9}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter valid Phone number';
    else
      return null;
  }

  String validatePrice(String value) {
    Pattern pattern = r'^\d+(\.\d{1,2})?$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Only two digits are accepted after decimal';
    else
      return null;
  }

  String validateStrings(String value) {
    Pattern pattern = r'^[a-zA-Z][a-zA-Z\s]*$';
    RegExp regex = new RegExp(pattern);
    if (value.length < 2)
      return 'Length should be of 2 alphabets atleast';
    else if (!regex.hasMatch(value))
      return 'It should contain alphabets only';
    else
      return null;
  }

  String validateDescription(String value) {
    Pattern pattern = r'^[a-zA-Z][a-zA-Z\s]{10,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Length should be of 10 alphabets atleast';
    else
      return null;
  }
}

final Validator validator = Validator();
