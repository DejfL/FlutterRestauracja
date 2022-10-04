import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:restauracja/models/cart.dart';
import 'package:restauracja/models/modification.dart';
import 'package:restauracja/models/topping.dart';

Future<void> sednOrderEmail(List<Cart> products, double totalPrice) async {
  final String emailBody = _getEmailBody(products, totalPrice);

  final smtpServer = SmtpServer(
    'smtp-relay.sendinblue.com',
    username: 'restaurancjaapp@gmail.com',
    password: 'y2KURLfFqnIDrPMX',
    port: 587,
  );

  final message = Message()
    ..from = const Address('restaurancjaapp@gmail.com', 'Restaurancja')
    ..recipients.add('klaudiad1808@gmail.com')
    ..subject = 'Twoje zamówienie w restaurancji'
    ..text = emailBody;

  try {
    send(message, smtpServer);
  } catch (e) {}
}

String _getEmailBody(List<Cart> products, double totalPrice) {
  String body = "Witaj Dejfl\n\n";
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
