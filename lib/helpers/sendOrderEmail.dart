import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:restauracja/helpers/account.dart';
import 'package:restauracja/helpers/emailSettings.dart';
import 'package:restauracja/models/account.dart';
import 'package:restauracja/models/cart.dart';
import 'package:restauracja/models/emailSettings.dart';
import 'package:restauracja/models/modification.dart';
import 'package:restauracja/models/topping.dart';

Future<void> sednOrderEmail(List<Cart> products, double totalPrice) async {
  try {
    final Account account = await getAccount();
    final String emailBody = _getEmailBody(products, totalPrice, account.name);
    final EmailSettings emailSettings = await getEmailSettings();

    final smtpServer = SmtpServer(
      emailSettings.smtp,
      username: emailSettings.username,
      password: emailSettings.password,
      port: emailSettings.port,
    );

    final message = Message()
      ..from = const Address('restaurancjaapp@gmail.com', 'Restaurancja')
      ..recipients.add(account.email)
      ..subject = 'Twoje zamówienie w restaurancji'
      ..text = emailBody;

    send(message, smtpServer);
  } catch (e) {
    int a = 5;
  }
}

String _getEmailBody(List<Cart> products, double totalPrice, String name) {
  String body = "Witaj $name\n\n";
  body += 'Twoje zamówienie w restaurancji:\n';

  for (Cart product in products) {
    body += 'Nazwa: ${product.name}\n';

    if (product.topings.isNotEmpty) {
      body += 'Dodatki:\n';
      for (Topping topping in product.topings) {
        body += '${topping.name} +${topping.price.toStringAsFixed(2)} zł\n';
      }
      body += '\n';
    }

    if (product.modifications.isNotEmpty) {
      body += 'Modyfikacje:\n';
      for (Modification modification in product.modifications) {
        body +=
            '${modification.name} +${modification.price.toStringAsFixed(2)} zł\n';
      }
      body += '\n';
    }

    if (product.comment.isNotEmpty) {
      body += 'Uwagi:\n';
      body += '${product.comment}\n\n';
    }

    body += 'Cena: ${product.cost.toStringAsFixed(2)} zł\n';
    body += 'Ilość: ${product.quantity}\n';
    body += 'Razem: ${product.cost.toStringAsFixed(2)} zł\n\n';
  }

  body += 'Łączna suma zamówienia to: ${totalPrice.toStringAsFixed(2)} zł';
  return body;
}
