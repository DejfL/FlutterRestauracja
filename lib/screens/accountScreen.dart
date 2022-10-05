import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:restauracja/const.dart';
import 'package:restauracja/helpers/account.dart';
import 'package:restauracja/models/account.dart';
import 'package:restauracja/widgets/buttons.dart';
import 'package:restauracja/widgets/textFormField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _getAccount();
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _emailEditingController.dispose();
    super.dispose();
  }

  void _getAccount() async {
    if (await isUserLogged()) {
      Account account = await getAccount();
      _nameEditingController.text = account.name;
      _emailEditingController.text = account.email;
    }
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

  Form textFields(BuildContext context) {
    return Form(
      key: _formKey,
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
            textEditingController: _nameEditingController,
            autoFocus: true,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Email:',
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: primaryColor),
          ),
          MyTextFormField(
            textEditingController: _emailEditingController,
            textInputType: TextInputType.emailAddress,
            onFieldSubmitted: _confirm,
          ),
        ],
      ),
    );
  }

  void _confirm(_) async {
    if (_formKey.currentState!.validate()) {
      saveAccount(_nameEditingController.text, _emailEditingController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text('Zapisano'),
        ),
      );
    }
  }
}
