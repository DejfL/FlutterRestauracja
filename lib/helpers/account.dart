import 'package:restauracja/models/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

void saveAccount(String name, String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('name', name);
  prefs.setString('email', email);
}

Future<Account> getAccount() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return Account(
      prefs.getString('name').toString(), prefs.getString('email').toString());
}

Future<bool> isUserLogged() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.getString('name') != null && prefs.getString('email') != null) {
    return true;
  } else {
    return false;
  }
}
