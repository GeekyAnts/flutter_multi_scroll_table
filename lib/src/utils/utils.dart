import 'package:flutter/material.dart';

import '../../flutter_multi_scroll_table.dart';

class Utils {
  static int compareTexts(String textA, String textB) {
    final numA = int.tryParse(textA) ?? double.tryParse(textA);
    final numB = int.tryParse(textB) ?? double.tryParse(textB);

    if (numA != null && numB != null) {
      return numA.compareTo(numB);
    } else {
      List<String> wordsA = textA.split(' ');
      List<String> wordsB = textB.split(' ');

      // Compare the first word of each string
      String firstWordA = wordsA.isNotEmpty ? wordsA.first : textA;
      String firstWordB = wordsB.isNotEmpty ? wordsB.first : textB;

      int firstWordComparison = firstWordA.compareTo(firstWordB);

      // If first words are the same, compare the full strings
      if (firstWordComparison == 0) {
        return textA.compareTo(textB);
      } else {
        return firstWordComparison;
      }
    }
  }

  static String getTextFromScrollableColumn(Widget widget, int columnIndex) {
    if (widget is Column && widget.children.isNotEmpty) {
      for (var child in widget.children) {
        if (child is Row && child.children.length > columnIndex) {
          final cell = child.children[columnIndex];
          if (cell is EachCell) {
            return cell.text;
          }
        }
      }
    } else if (widget is Row && widget.children.isNotEmpty) {}
    return '';
  }

  static String getTextFromWidget(Widget widget) {
    if (widget is EachCell) {
      return widget.text;
    }
    return '';
  }

  // static int compareTexts(String textA, String textB) {
  //   return textA.compareTo(textB);
  // }

  static int compare(dynamic a, dynamic b) {
    if (a is num && b is num) {
      return a.compareTo(b);
    } else {
      return a.toString().compareTo(b.toString());
    }
  }
}
