// // Flutter imports:// import 'package:flutter/material.dart';// import 'package:form_builder_validators/form_builder_validators.dart';//// import '../../constants/text_style.dart';//////// class CustomDropdown extends StatelessWidget {//   final String? attribute;//   final InputDecoration? decoration;//   final bool? allowClear;//   final String? hintText;//   final FormFieldValidator<String>? validator;//   final List<String>? items;//   final void Function(dynamic)? onChange;//   final String? initialValue;////    const CustomDropdown({//     this.attribute,//     this.decoration,//     this.allowClear,//     this.hintText,//     this.validator,//     this.items,//     this.onChange,//     this.initialValue,//   });////   @override//   Widget build(BuildContext context) {//     return FormBuilderDropdown(//       name: attribute ?? 'category',//       onChanged: onChange,//       initialValue: initialValue,//       decoration: decoration ??//           const InputDecoration(//             labelText: 'Category',//           ),//       allowClear: allowClear ?? true,//       style: bS12W4,//       hint: Text(//         hintText ?? 'Select',//         style: bS12W4//       ),//       validator: FormBuilderValidators.required(//           errorText: 'Dropdown Field is required.'),//       items: (items ??//           ["Category 1", "Category 2", "Category 3", "Category 4"])//           .map(//             (value) => DropdownMenuItem(//           value: value,//           child: Text(//               value,//             style: bS12W4//           ),//         ),//       )//           .toList(),//     );//   }// }