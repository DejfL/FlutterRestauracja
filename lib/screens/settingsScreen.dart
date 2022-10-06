import 'package:flutter/material.dart';
import 'package:restauracja/const.dart';
import 'package:restauracja/helpers/emailSettings.dart';
import 'package:restauracja/models/emailSettings.dart';
import 'package:restauracja/widgets/buttons.dart';
import 'package:restauracja/widgets/mySnackBar.dart';
import 'package:restauracja/widgets/textFormField.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _usernameEditingController =
      TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _smtpEditingController = TextEditingController();
  final TextEditingController _portEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _getEmailSettings();
  }

  @override
  void dispose() {
    _usernameEditingController.dispose();
    _passwordEditingController.dispose();
    _smtpEditingController.dispose();
    _portEditingController.dispose();
    super.dispose();
  }

  void _getEmailSettings() async {
    EmailSettings emailSettings = await getEmailSettings();
    _usernameEditingController.text = emailSettings.username;
    _passwordEditingController.text = emailSettings.password;
    _smtpEditingController.text = emailSettings.smtp;
    _portEditingController.text = emailSettings.port.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          textFields(context),
          const Spacer(),
          PrimaryButton(
            text: 'Zatwierdź',
            onClick: () {
              _confirm('');
            },
          )
        ],
      ),
    );
  }

  Widget textFields(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nazwa:',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: primaryColor),
            ),
            MyTextFormField(
              textEditingController: _usernameEditingController,
              autoFocus: true,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Hasło:',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: primaryColor),
            ),
            MyTextFormField(
              textEditingController: _passwordEditingController,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'SMTP:',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: primaryColor),
            ),
            MyTextFormField(
              textEditingController: _smtpEditingController,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Port:',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: primaryColor),
            ),
            MyTextFormField(
              textEditingController: _portEditingController,
              textInputType: TextInputType.number,
              onFieldSubmitted: _confirm,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  void _confirm(_) async {
    if (_formKey.currentState!.validate()) {
      saveEmailSettings(
        _usernameEditingController.text,
        _passwordEditingController.text,
        _smtpEditingController.text,
        int.parse(_portEditingController.text),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        mySnackBar('Zapisano'),
      );
    }
  }
}
