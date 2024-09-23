import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolati2024/providers/dark_mode_provider.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {super.key,
      required this.text,
      required this.onTab,
      required this.icon,
      this.withDivider = true});
  final String text;
  final Function onTab;
  final IconData icon;
  final bool withDivider;
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(builder: (context, darkModeConsumer, _) {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              onTab();
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: darkModeConsumer.isDark
                      ? Colors.white24
                      : Colors.blue.withOpacity(0.1)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(icon,
                        color: darkModeConsumer.isDark
                            ? Colors.white60
                            : Colors.black),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                          color: darkModeConsumer.isDark
                              ? Colors.white60
                              : Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
          if (withDivider)
            const Divider(
              thickness: 1,
              endIndent: 5,
              indent: 5,
            ),
        ],
      );
    });
  }
}
