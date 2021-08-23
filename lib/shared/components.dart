import 'package:flutter/material.dart';

void navigateTo(context,widget) => Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => widget
    )
);

void navigateAndFinish(context,widget) => Navigator.pushAndRemoveUntil(
  context,
    MaterialPageRoute(
        builder: (context) => widget
    ),
    (route){
    return false;
    }
);

Widget defaultFormField({
    @required TextEditingController controller,
    @required TextInputType type,
    Function onSubmit,
    Function onChange,
    Function onTab,
    bool isPassword = false,
    @required Function validate,
    @required String label,
    @required IconData prefix,
    IconData suffix,
    bool isClickable = true,
}) => TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    validator: validate,
    onTap: onTab,
    enabled: isClickable,
    decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
            prefix,
        ),
        suffixIcon: suffix != null ? Icon(suffix) : null,
        border: OutlineInputBorder(),
    ),
);