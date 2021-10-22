import 'package:flutter/material.dart';

class CustomTextField {
  static Widget customTextField({
    TextEditingController? controller,
    bool ? focus,
    String? label,
    String? hint,
    Icon? prefixIcon,
    Widget? suffixIcon,
    Function? ontap,
  }){
    return Container(
      child:TextField(
        showCursor: true,
        readOnly: true,
        autofocus: focus ?? false,
        onTap:(){
          ontap!();
        },
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
          labelText: label,
          hintText: hint,
        ),
      ) ,
    );
  }

  static Widget textFieldCustom({
     TextEditingController? controller,
     FocusNode? focusNode,
     String? label,
    String? hint,
    bool? enabled,
     double? width,
     Icon? prefixIcon,
    Widget? suffixIcon,
    Function(String)? function,
    Function? onTap,
  }) {
    return
    Container(
        width: width! * 0.8,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: new InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            labelText: label,
            filled: true,
            enabled: enabled ?? false,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(
                color: Colors.blue.shade300,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.all(15),
            hintText: hint ?? '',
          ),
        ),
      );
  }


}