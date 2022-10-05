import 'package:restauracja/models/emailSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void saveEmailSettings(
    String username, String password, String smtp, int port) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('username', username);
  prefs.setString('password', password);
  prefs.setString('smtp', smtp);
  prefs.setInt('port', port);
}

Future<EmailSettings> getEmailSettings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return EmailSettings(
    username: prefs.getString('username').toString(),
    password: prefs.getString('password').toString(),
    smtp: prefs.getString('smtp').toString(),
    port: int.parse(prefs.getInt('port').toString()),
  );
}

Future<bool> emailSettingsExist() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.getString('username') != null &&
      prefs.getString('password') != null &&
      prefs.getString('smtp') != null &&
      prefs.getInt('port') != null) {
    return true;
  } else {
    return false;
  }
}
