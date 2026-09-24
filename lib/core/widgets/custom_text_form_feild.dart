import 'package:flutter/material.dart';
import 'package:todo/core/theme/app_text_style.dart';

class CustomTextFormFeild extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String? Function(String?)? validator;
  final String hintText;
  final int? maxlines;
  final bool? readonly;
  final void Function()? onTap;
  const CustomTextFormFeild({
    super.key,
    required this.controller,required this.title,this.validator,
    required this.hintText,
    this.maxlines = 1, this.readonly, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.bodylargeStyle),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          readOnly: readonly??false,
          onTap: onTap,
          onTapOutside: (v) {
            FocusScope.of(context).unfocus();
          },
          validator: validator,
          maxLines: maxlines,

          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 210, 198, 198),
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
