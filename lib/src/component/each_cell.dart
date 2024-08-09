import 'package:flutter/material.dart';

/// A widget that represents a single cell in a table.
/// It can be used for both header and data cells with various customization options.
class EachCell extends StatelessWidget {
  /// Creates an [EachCell] widget.
  ///
  /// The [text] parameter must not be null.
  const EachCell({
    Key? key,
    required this.text,
    this.isHeader = false,
    this.width,
    this.height,
    this.headerTextStyle,
    this.dataTextStyle,
    this.isLeftAlign = false,
    this.headerBackgroundColor,
    this.dataBackgroundColor,
    this.padding,
    this.border,
    this.borderRadius,
    this.margin,
    this.isExpandable = false,
    this.priority,
  }) : super(key: key);

  /// The text content of the cell.
  final String text;

  /// Whether the cell is a header cell. Default is false.
  final bool isHeader;

  /// Whether the text should be left-aligned. Default is false.
  final bool isLeftAlign;

  /// The width of the cell.
  final double? width;

  /// The height of the cell.
  final double? height;

  ///  The text style for the header of cell content.
  final TextStyle? headerTextStyle;

  /// The text style for the data of cell content.
  final TextStyle? dataTextStyle;

  /// The background color for header the cell.
  final Color? headerBackgroundColor;

  /// The background color for data of the cell.
  final Color? dataBackgroundColor;

  /// The padding inside the cell.
  final EdgeInsetsGeometry? padding;

  /// The margin outside the cell.
  final EdgeInsetsGeometry? margin;

  /// The border of the cell.
  final BoxBorder? border;

  /// The border radius of the cell.
  final BorderRadiusGeometry? borderRadius;

  /// Whether the cell is expandable. Default is false.
  final bool isExpandable;

  final int? priority;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          height: height ?? 40,
          alignment: isHeader ? Alignment.bottomCenter : Alignment.center,
          padding: padding,
          margin: margin,
          decoration: BoxDecoration(
            border: border,
            color: isHeader ? headerBackgroundColor : dataBackgroundColor,
            borderRadius: borderRadius,
          ),
          width: constraints.maxWidth,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
            ),
            child: Center(
              child: Text(
                text,
                style: headerTextStyle ??
                    dataTextStyle ??
                    const TextStyle(height: 1, color: Colors.black),
                textAlign: isLeftAlign ? TextAlign.left : TextAlign.center,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        );
      },
    );
  }
}

extension EachCellCopyWith on EachCell {
  EachCell copyWith({
    String? text,
    bool? isHeader,
    bool? isLeftAlign,
    double? width,
    double? height,
    TextStyle? headerTextStyle,
    TextStyle? dataTextStyle,
    Color? headerBackgroundColor,
    Color? dataBackgroundColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    bool? isExpandable,
    int? priority,
  }) {
    return EachCell(
      text: text ?? this.text,
      isHeader: isHeader ?? this.isHeader,
      isLeftAlign: isLeftAlign ?? this.isLeftAlign,
      width: width ?? this.width,
      height: height ?? this.height,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      dataBackgroundColor: dataBackgroundColor ?? this.dataBackgroundColor,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
      isExpandable: isExpandable ?? this.isExpandable,
      priority: priority ?? this.priority,
    );
  }
}
