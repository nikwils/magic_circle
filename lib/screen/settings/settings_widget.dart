import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:surf_practice_magic_ball/data/providers/providers.dart';
import 'package:surf_practice_magic_ball/screen/settings/settings_provider.dart';

class SettingsWidget extends ConsumerStatefulWidget {
  const SettingsWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends ConsumerState<SettingsWidget> {
  List<DropdownMenuItem<Curve>> get dropdownItems {
    List<DropdownMenuItem<Curve>> menuItems = const [
      DropdownMenuItem(value: Curves.linear, child: Text("linear")),
      DropdownMenuItem(value: Curves.easeIn, child: Text("easeIn")),
      DropdownMenuItem(
          value: Curves.fastLinearToSlowEaseIn,
          child: Text("fastLinearToSlowEaseIn ")),
      DropdownMenuItem(value: Curves.bounceIn, child: Text("bounceIn")),
      DropdownMenuItem(value: Curves.slowMiddle, child: Text("slowMiddle")),
    ];

    return menuItems;
  }

  Widget customDropdownButton(Size size, SettingsProvider notifier) =>
      DropdownButtonHideUnderline(
        child: DropdownButton2<Curve>(
          isExpanded: true,
          items: dropdownItems,
          value: notifier.newCurve,
          onChanged: (Curve? value) {
            setState(() {
              notifier.setNewCurve = value!;
            });
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            width: size.width / 2 + 20,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white,
              ),
              color: Colors.blue[500],
            ),
            elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
            ),
            iconSize: 26,
            iconEnabledColor: Colors.white,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 170,
            width: size.width / 2 + 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.blue[300],
            ),
            offset: const Offset(-10, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final SettingsProvider notifier = ref.watch(settingsProvider.notifier);
    int newSpeed = notifier.newSpeed;
    Size size = MediaQuery.of(context).size;

    Widget buildColorPicker() {
      return BlockPicker(
        onColorChanged: (Color color) => setState(() {
          notifier.setNewColor = color;
        }),
        pickerColor: notifier.newColor,
      );
    }

    void pickColor(BuildContext context) => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Выбрать цвет'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildColorPicker(),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('ВЫБРАТЬ'),
                ),
              ],
            ),
          ),
        );

    Widget sizedBox(double? height) {
      return SizedBox(
        height: height,
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        children: [
          const Text('Цвет магического шара'),
          ElevatedButton(
            onPressed: () => pickColor(context),
            child: const Text('Изменить цвет'),
          ),
          sizedBox(40),
          const Text('Скорость анимации'),
          Slider.adaptive(
            min: 500,
            max: 7000,
            value: newSpeed.toDouble(),
            onChanged: (double value) {
              setState(() {
                notifier.setNewSpeed = value.toInt();
              });
            },
          ),
          sizedBox(40),
          const Text('Кривая анимации'),
          customDropdownButton(size, notifier)
        ],
      ),
    );
  }
}
