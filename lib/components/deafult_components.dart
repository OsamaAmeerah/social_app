import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget myDivider() => Padding(
  padding:  const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey,
  ),
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  Color? suffixIconColor,
  Color? prefixIconColor,
  Color? focusColor,
  Color? cursorColor,
  dynamic enabledBorderStyle,
  dynamic focusedBorderStyle,
  TextStyle? style,
  dynamic labelStyle,
  void Function(String)? onChange,
  void Function()? onTap,
  void Function()? suffixPressed,
  required String label,
  bool isClickable = true,
  IconData? prefix,
  IconData? suffix,
  required dynamic validate,
  bool isPassword = false,
}) =>
    TextFormField(
      cursorColor: cursorColor,
      style: style,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      obscureText: isPassword,
      enabled: isClickable,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        suffixIconColor: suffixIconColor,
        prefixIconColor: prefixIconColor,
        focusedBorder: focusedBorderStyle,
        enabledBorder: enabledBorderStyle,
        labelText: label,
        labelStyle: labelStyle,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        ) : null,
        border: const OutlineInputBorder(),
      ),
    );

PreferredSizeWidget defaultAppBar ({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
})=> AppBar(
  leading: IconButton(
    onPressed: (){
     Navigator.pop(context);
    },
    icon: const Icon(
      Icons.arrow_back_ios_new,
    ),
  ),
  titleSpacing: 5.0,
  title:  Text(
    title!,
  ),
  actions: actions,
);

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required void Function()? todofunction,
  required String text,
  bool isUpperCase = true,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20),
        color: background,
      ),
      child: MaterialButton(

        onPressed: todofunction,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

void navigateTo (context , widget) => Navigator.push(
  context, MaterialPageRoute
  (
  builder: (context) =>  widget,
),
);
void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route)  // بقدر ارجع للسكرين الي قبلها ولا لا
      {
        return false;
      },
    );


void printFullText(String text)// هاي ميثود بتطبع التكست بشكل كامل في الكونسول
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) =>match.group(0));
}

void showToast({
  required String text,
  required ToastStates state,
})
{
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
// ignore: constant_identifier_names
enum ToastStates {SUCCESS , ERROR , WARNING} //لما يكون عندك كذا اختيار من اشي
Color chooseToastColor(ToastStates state)
{
  Color color;
  switch(state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

String token = '';
String? uId = '';
 FirebaseFirestore fireStore = FirebaseFirestore.instance;
 FirebaseAuth fireAuth = FirebaseAuth.instance;

