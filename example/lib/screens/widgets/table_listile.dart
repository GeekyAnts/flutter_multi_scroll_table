import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final Color leadingIconColor;
  final IconData trailingIcon;
  final Color trailingIconColor;
  final Color tileColor;
  final VoidCallback onTap;
  final Color titleColor;
  final Color subtitleColor;
  final Color leadingIconBackgroundColor;
  final double leadingIconSize;
  final double trailingIconSize;
  final EdgeInsetsGeometry contentPadding;
  final double borderRadius;
  final BorderSide borderSide;
  final Color hoverColor;
  final Color splashColor;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.leadingIconColor,
    required this.trailingIcon,
    required this.trailingIconColor,
    required this.tileColor,
    required this.onTap,
    required this.titleColor,
    required this.subtitleColor,
    required this.leadingIconBackgroundColor,
    this.leadingIconSize = 30.0,
    this.trailingIconSize = 20.0,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
    this.borderRadius = 15.0,
    this.borderSide = const BorderSide(width: 1.0, color: Colors.transparent),
    this.hoverColor = Colors.transparent,
    this.splashColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: titleColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: subtitleColor,
        ),
      ),
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: leadingIconBackgroundColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(
          leadingIcon,
          color: leadingIconColor,
          size: leadingIconSize,
        ),
      ),
      trailing: Icon(
        trailingIcon,
        color: trailingIconColor,
        size: trailingIconSize,
      ),
      tileColor: tileColor,
      contentPadding: contentPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: borderSide,
      ),
      onTap: onTap,
      hoverColor: hoverColor,
      splashColor: splashColor,
    );
  }
}
