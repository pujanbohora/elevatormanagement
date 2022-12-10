import 'package:flutter/material.dart';import '../../constants/app_color.dart';import '../../constants/font_size.dart';class ActionButton extends StatelessWidget {  const ActionButton({    Key? key,    required this.text,    required this.onPressed,    this.isLoading = false,    this.background = Colors.black,    this.width = 130,    this.height = 47,    this.borderRadius = 25,    this.borderColor = Colors.transparent,    this.borderWidth = 0,  }) : super(key: key);  final Text text;  final Function() onPressed;  final double width;  final double height;  final Color background;  final double borderRadius;  final Color borderColor;  final double borderWidth;  final bool isLoading;  @override  Widget build(BuildContext context) {    return Container(      decoration: BoxDecoration(        color: background,        border: Border.all(          color: borderColor,          width: borderWidth,        ),        borderRadius: BorderRadius.circular(borderRadius),      ),      height: height,      width: double.infinity,      child: TextButton(        onPressed: onPressed,        style: ButtonStyle(            backgroundColor: MaterialStateProperty.all(purpleColor),            foregroundColor: MaterialStateProperty.all(white),            padding: MaterialStateProperty.all(                EdgeInsets.symmetric(vertical: 14)),            textStyle: MaterialStateProperty.all(TextStyle(              fontSize: font_14,              fontWeight: FontWeight.w700,            ))),        child: isLoading            ? const Center(            child: CircularProgressIndicator(              color: white,              strokeWidth: 2,            )) : text,      ),    );    // Container(    //   width: width,    //   height: height,    //   decoration: BoxDecoration(    //     color: background,    //     border: Border.all(    //       color: borderColor,    //       width: borderWidth,    //     ),    //     borderRadius: BorderRadius.circular(borderRadius),    //   ),    //   child: isLoading    //       ? const Center(    //       child: CircularProgressIndicator(    //         color: white,    //         strokeWidth: 1,    //       ))    //       : Center(child: text),    // ),  }}