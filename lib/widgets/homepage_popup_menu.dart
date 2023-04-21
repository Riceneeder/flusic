import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:libadwaita_bitsdojo/libadwaita_bitsdojo.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePagePpopupMenu extends StatelessWidget {
  const HomePagePpopupMenu({
    super.key,
    required this.developers,
  });

  final Map<String, String> developers;

  @override
  Widget build(BuildContext context) {
    return GtkPopupMenu(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AdwButton.flat(
            padding: AdwButton.defaultButtonPadding.copyWith(
              top: 10,
              bottom: 10,
            ),
            onPressed: () => showDialog<Widget>(
              context: context,
              builder: (ctx) => AdwAboutWindow(
                issueTrackerLink: 'https://github.com/riceneeder',
                appIcon: SvgPicture.asset(
                  'asset/icon.svg',
                  height: 100,
                ),
                actions: AdwActions(
                  onClose: Navigator.of(context).pop,
                  onHeaderDrag: appWindow?.startDragging,
                  onDoubleTap: appWindow?.maximizeOrRestore,
                ),
                credits: [
                  AdwPreferencesGroup.credits(
                    title: 'Developers',
                    children: developers.entries
                        .map(
                          (e) => AdwActionRow(
                            title: e.key,
                            onActivated: () => launchUrl(
                              Uri.parse('https://github.com/${e.value}'),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
                copyright: 'Copyright 2023',
                license: const Text(
                  'GNU LGPL-3.0, This program comes with no warranty.',
                ),
              ),
            ),
            child: const Text(
              '关于',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
