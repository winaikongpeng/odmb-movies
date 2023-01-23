import 'package:flutter/material.dart';

class CommonWidget {
  static AppBar standardAppbar(
      {required BuildContext ctx,
      required String title,
      bool? showLeading = false}) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      leading: showLeading == false
          ? null
          : InkWell(
              onTap: () {
                Navigator.pop(ctx);
              },
              child: const Icon(Icons.arrow_back)),
    );
  }

  static Widget loading() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.grey,
        strokeWidth: 5,
      ),
    );
  }

  static Widget textError(
          {required BuildContext ctx, required String message}) =>
      Center(
          child: Text(
        message,
        style: const TextStyle(color: Colors.red),
      ));

  static Widget textNotFind(
          {required BuildContext ctx, required String message}) =>
      Center(
          child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ));

  static Widget standardButton(
      {required BuildContext context,
      required String title,
      required void Function()? onPressed}) {
    return ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
        ),
        onPressed: onPressed,
        child: Text(title));
  }

  static TextFormField textFormfieldStandard(
      {required String label,
      required TextEditingController controller,
      required String? Function(String?)? validator}) {
    return TextFormField(
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          label: Text(label),
          labelStyle: const TextStyle(color: Colors.white),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2)),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2))),
      maxLength: 20,
      buildCounter: counter,
      controller: controller,
      validator: validator,
    );
  }

  static TextFormField textFormfieldUseSuffix(
      {required String label,
      required TextEditingController controller,
      required String? Function(String?)? validator,
      required bool showPassword,
      required void Function()? onTapIcon}) {
    return TextFormField(
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      obscureText: !showPassword,
      decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: onTapIcon,
            child: Icon(
              showPassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
          ),
          label: Text(label),
          labelStyle: const TextStyle(color: Colors.white),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2)),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2))),
      maxLength: 20,
      buildCounter: counter,
      controller: controller,
      validator: validator,
    );
  }

  static Widget? counter(
    BuildContext context, {
    required int currentLength,
    required int? maxLength,
    required bool isFocused,
  }) {
    return null;
  }
}
