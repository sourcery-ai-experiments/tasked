import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonItem extends StatelessWidget {
  const ButtonItem({
    super.key,
    this.color,
  });

final Color? color;
final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final cardWidth = Get.width - 2 * 8.0;
    final cardHeight = cardWidth / 1.618 / 2;

final decoration = BoxDecoration(
            borderRadius: const BorderRadius.circular(20),
            color: this.color ?? colorScheme.primary,
          );

    return Material(
      elevation: 4,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: InkWell(
        onTap: () {
          //Get.to(Routes.PATHS);
        },
        child: Container(
          width: cardWidth,
          height: cardHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'aspect_ratio',
                style: textTheme.headlineSmall!
                    .copyWith(color: textColor ??  colorScheme.onPrimary),
              ), // Text
            ],
          ), // Column
          padding: const EdgeInsets.all(16),
          decoration: decoration,
        ), //Container
      ), // InkWell
    ); // Material
  }
}
