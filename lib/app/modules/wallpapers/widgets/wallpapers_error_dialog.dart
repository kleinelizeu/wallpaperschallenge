import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers_challenge/app/shared/utils/constants.dart';

void wallpapersErrorDialog(BuildContext ctx, String description) {
  showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
            backgroundColor: primaryBlue,
            title: Text('Ops! Ocorreu um erro.'),
            content: Text(description),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("fechar"),
              )
            ],
          ));
}
