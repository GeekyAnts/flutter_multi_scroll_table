import 'package:example/samples/expandable_column_table.dart';
import 'package:flutter/material.dart';
import 'package:example/samples/fixed_column_table.dart';
import 'package:example/samples/scrollable_table.dart';
import 'package:example/samples/json_data_table.dart';
import 'package:example/samples/specific_row_styling.dart';
import 'package:example/screens/widgets/appbar.dart';
import 'package:example/utils/strings.dart';

import '../samples/styled_scrollable_table.dart';
import 'widgets/table_listile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TableAppBar(
        title: AppStrings.appTitle,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // ListTile 1 - Fixed Column Table Example
            CustomListTile(
              title: AppStrings.fixedColumnTableTitle,
              subtitle: AppStrings.fixedColumnTableSubtitle,
              leadingIcon: Icons.table_chart,
              leadingIconColor: Colors.white,
              leadingIconBackgroundColor: Colors.blueAccent,
              trailingIcon: Icons.arrow_forward_ios,
              trailingIconColor: Colors.blueAccent,
              tileColor: Colors.blue[50]!,
              titleColor: Colors.blueAccent,
              subtitleColor: Colors.grey,
              borderSide: BorderSide(color: Colors.blueAccent.withOpacity(0.5)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FixedColumnTableExample(),
                  ),
                );
              },
              hoverColor: Colors.blueAccent.withOpacity(0.1),
              splashColor: Colors.blueAccent.withOpacity(0.2),
            ),

            const SizedBox(height: 20),

            // ListTile 2 - Styled Table Example
            CustomListTile(
              title: AppStrings.styledTableTitle,
              subtitle: AppStrings.styledTableSubtitle,
              leadingIcon: Icons.style,
              leadingIconColor: Colors.white,
              leadingIconBackgroundColor: Colors.deepPurpleAccent,
              trailingIcon: Icons.arrow_forward_ios,
              trailingIconColor: Colors.deepPurple,
              tileColor: Colors.deepPurple[50]!,
              titleColor: Colors.deepPurple,
              subtitleColor: Colors.deepPurpleAccent,
              borderSide:
                  BorderSide(color: Colors.deepPurpleAccent.withOpacity(0.5)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const StyledScrollableTableExample()),
                );
              },
              hoverColor: Colors.deepPurpleAccent.withOpacity(0.1),
              splashColor: Colors.deepPurple.withOpacity(0.2),
            ),

            const SizedBox(height: 20),

            // ListTile 3 - Scrollable Table Example
            CustomListTile(
              title: AppStrings.scrollableTableTitle,
              subtitle: AppStrings.scrollableTableSubtitle,
              leadingIcon: Icons.view_agenda,
              leadingIconColor: Colors.white,
              leadingIconBackgroundColor: Colors.teal,
              trailingIcon: Icons.arrow_forward_ios,
              trailingIconColor: Colors.teal,
              tileColor: Colors.teal[50]!,
              titleColor: Colors.teal,
              subtitleColor: Colors.teal,
              borderSide: BorderSide(color: Colors.teal.withOpacity(0.4)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ScrollableTableExample()),
                );
              },
              hoverColor: Colors.teal.withOpacity(0.1),
              splashColor: Colors.teal.withOpacity(0.2),
            ),

            const SizedBox(height: 20),

            // ListTile 4 - JSON Data Table Example
            CustomListTile(
              title: AppStrings.jsonDataTableTitle,
              subtitle: AppStrings.jsonDataTableSubtitle,
              leadingIcon: Icons.insert_chart,
              leadingIconColor: Colors.white,
              leadingIconBackgroundColor: Colors.red,
              trailingIcon: Icons.arrow_forward_ios,
              trailingIconColor: Colors.red,
              tileColor: Colors.red[50]!,
              titleColor: Colors.red,
              subtitleColor: Colors.red,
              borderSide: BorderSide(color: Colors.red.withOpacity(0.5)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const JSONDataTableExample(),
                  ),
                );
              },
              hoverColor: Colors.red.withOpacity(0.1),
              splashColor: Colors.red.withOpacity(0.2),
            ),

            const SizedBox(height: 20),

            // ListTile 5 - Specific Row Styling Table Example
            CustomListTile(
              title: AppStrings.specificRowStylingTableTitle,
              subtitle: AppStrings.specificRowStylingTableSubtitle,
              leadingIcon: Icons.format_paint,
              leadingIconColor: Colors.white,
              leadingIconBackgroundColor: Colors.indigo,
              trailingIcon: Icons.arrow_forward_ios,
              trailingIconColor: Colors.indigo,
              tileColor: Colors.indigo[50]!,
              titleColor: Colors.indigo,
              subtitleColor: Colors.indigo,
              borderSide: BorderSide(color: Colors.indigo.withOpacity(0.5)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const SpecificRowStylingTableExample(),
                  ),
                );
              },
              hoverColor: Colors.indigo.withOpacity(0.1),
              splashColor: Colors.indigo.withOpacity(0.2),
            ),

            const SizedBox(height: 20),

            // ListTile 6 - Expandable Table Example
            CustomListTile(
              title: AppStrings.expandableColumnTableTitle,
              subtitle: AppStrings.expandableColumnTableSubtitle,
              leadingIcon: Icons.table_rows,
              leadingIconColor: Colors.white,
              leadingIconBackgroundColor: Colors.blueGrey,
              trailingIcon: Icons.arrow_forward_ios,
              trailingIconColor: Colors.blueGrey,
              tileColor: Colors.blueGrey[50]!,
              titleColor: Colors.blueGrey.shade900,
              subtitleColor: Colors.blueGrey,
              borderSide: BorderSide(color: Colors.blueGrey.withOpacity(0.5)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExpandableColumnTableExample(),
                  ),
                );
              },
              hoverColor: Colors.blueGrey.withOpacity(0.1),
              splashColor: Colors.blueGrey.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}
