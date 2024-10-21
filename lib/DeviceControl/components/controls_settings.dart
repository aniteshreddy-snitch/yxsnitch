import 'package:flutter/material.dart';

class ControlSettings extends StatefulWidget {
  const ControlSettings({super.key});

  @override
  State<ControlSettings> createState() => _ControlSettingsState();
}

class _ControlSettingsState extends State<ControlSettings> {
  bool light = false;
  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Column(
          children: [
            SwitchControl(active: true, description: "Room Lights"),
            SizedBox(
              height: 5,
            ),
            SwitchControl(active: false, description: 'Strobe'),
            SizedBox(
              height: 5,
            ),
            SwitchControl(active: false, description: 'Locate Mode'),
            SizedBox(
              height: 5,
            ),
            SwitchControl(active: false, description: 'Switch Lights'),
            SizedBox(
              height: 5,
            ),
            SwitchControl(active: false, description: 'Strobe'),
            SizedBox(
              height: 5,
            ),
            ColorRadioButtons()
          ],
        ));
  }
}

class SwitchControl extends StatefulWidget {
  final bool active;
  final String description;
  const SwitchControl(
      {super.key, required this.active, required this.description});

  @override
  State<SwitchControl> createState() =>
      // ignore: no_logic_in_create_state
      _SwitchControlState(active, description);
}

class _SwitchControlState extends State<SwitchControl> {
  bool active;
  final String description;
  _SwitchControlState(this.active, this.description);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 40, // Adjust this value to change the width
          height: 25, // Adjust this value to change the height
          child: FittedBox(
            fit: BoxFit.fill,
            child: Switch(
              value: active,
              onChanged: (bool value) {
                setState(() {
                  active = value;
                });
              },
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(description)
      ],
    );
  }
}

class ColorRadioButtons extends StatefulWidget {
  const ColorRadioButtons({super.key});

  @override
  _ColorRadioButtonsState createState() => _ColorRadioButtonsState();
}

class _ColorRadioButtonsState extends State<ColorRadioButtons> {
  String _selectedColor = 'Red'; // Default selected color

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,

      children: <Widget>[
        ListTile(
          minVerticalPadding: 0,
          visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4),
          title: const Text('Red'),
          leading: Radio<String>(
            value: 'Red',
            groupValue: _selectedColor,
            onChanged: (String? value) {
              setState(() {
                _selectedColor = value!;
              });
            },
          ),
        ),
        ListTile(
          minVerticalPadding: 0,
          title: const Text('Green'),
          leading: Radio<String>(
            value: 'Green',
            groupValue: _selectedColor,
            onChanged: (String? value) {
              setState(() {
                _selectedColor = value!;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Blue'),
          leading: Radio<String>(
            value: 'Blue',
            groupValue: _selectedColor,
            onChanged: (String? value) {
              setState(() {
                _selectedColor = value!;
              });
            },
          ),
        ),
      ],
    );
  }
}
