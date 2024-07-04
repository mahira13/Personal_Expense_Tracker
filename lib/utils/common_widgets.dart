import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/utils/constants/app_colors.dart';
import 'package:personal_expense_tracker/utils/constants/app_strings.dart';

Widget loading({String? content}) {
  return Center(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: primaryColor,
          ),
          Text(content ?? "")
        ]),
  );
}

Widget categoryCircleWidget(String category) {
  return CircleAvatar(
      radius: 28,
      backgroundColor: gradientColor5,
      child: category == "food"
          ? SvgPicture.asset(foodSvg)
          : category == "travel"
              ? SvgPicture.asset(
                  travelSvg,
                  height: 38,
                )
              : Image.asset(
                  miscImage,
                  width: 38,
                ));
}

Widget gradientExpenseContainer(var widget,
    {double margin = 18, double padding = 0}) {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: margin),
      padding: EdgeInsets.all(padding),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          color: scaffoldBackgroundColor),
      child: widget);
}

Widget gradientContainer(
  var widget,
) {
  return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            gradientColor1,
            gradientColor2,
            gradientColor3,
            gradientColor4,
            gradientColor5,
          ],
        ),
      ),
      child: widget);
}

showDeleteAlert(String content, {required VoidCallback onPressed}) {
  return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.0))),
      contentPadding: EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 16),
      actionsPadding: EdgeInsets.symmetric(horizontal: 72, vertical: 16),
      backgroundColor: scaffoldBackgroundColor,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.center,
            content,
            style: Theme.of(Get.context!).textTheme.headlineMedium,
          ),
        ],
      ),
      actions: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getElevatedButton("Yes", onPressed: onPressed),
            getTextButton(
              "No",
              onPressed: () {
                Get.back();
              },
            )
          ],
        )
      ]);
}

Widget getElevatedButton(String text, {required VoidCallback onPressed}) {
  return ElevatedButton(
      style: Theme.of(Get.context!).elevatedButtonTheme.style,
      onPressed: onPressed,
      child: Text(text));
}

Widget getTextButton(String text, {required VoidCallback onPressed}) {
  return TextButton(
      style: Theme.of(Get.context!).textButtonTheme.style,
      onPressed: onPressed,
      child: Text(text));
}

Widget commonTextfieldCL(TextEditingController controller, String hintText,
    {Widget? suffixIcon,
    String? prefix,
    Widget? prefixIcon,
    required VoidCallback onTap,
    bool readOnly = false,
    bool enabled = true,
    ValueChanged? onChanged,
    String? Function(String?)? validationFunc,
    void Function(String?)? onFieldSubmitted,
    int maxLines = 1,
    TextInputType textInputType = TextInputType.text,
    int maxLength = 150,
    FocusNode? focusnode,
    TextInputAction? textInputAction}) {
  return TextFormField(
    keyboardType: textInputType,
    enabled: enabled,
    validator: validationFunc,
    onChanged: onChanged,
    minLines: 1,
    maxLines: maxLines,
    readOnly: readOnly,
    onTap: onTap,
    style: const TextStyle(color: Colors.black),
    controller: controller,
    cursorColor: Colors.black,
    maxLength: maxLength,
    focusNode: focusnode,
    onFieldSubmitted: onFieldSubmitted,
    textInputAction: textInputAction,
    decoration: InputDecoration(
        counterStyle: const TextStyle(color: hintTextColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        hintStyle: const TextStyle(color: hintTextColor),
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixText: prefix,
        prefixIcon: prefixIcon,
        fillColor: Colors.white),
  ).paddingOnly(bottom: 16);
}
