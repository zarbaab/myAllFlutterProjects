import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart'; // Import color picker package
import 'package:file_picker/file_picker.dart'; // Import file picker package

void main() {
  runApp(XylophoneApp());
}

class XylophoneApp extends StatefulWidget {
  @override
  _XylophoneAppState createState() => _XylophoneAppState();
}

class _XylophoneAppState extends State<XylophoneApp> {
  // Define colors for two themes
  List<Color> themeOneColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.indigo,
    Colors.orange,
    Colors.pink,
    Colors.purple,
  ];

  List<Color> themeTwoColors = [
    Colors.cyan,
    Colors.lime,
    Colors.amber,
    Colors.yellow,
    Colors.teal,
    Colors.brown,
    Colors.grey,
  ];

  // Define sounds for two themes
  List<String> themeOneSounds = [
    'note1.wav',
    'note2.wav',
    'note3.wav',
    'note4.wav',
    'note5.wav',
    'note6.wav',
    'note7.wav',
  ];

  List<String> themeTwoSounds = [
    'n1.wav',
    'n2.wav',
    'n3.wav',
    'n4.wav',
    'n5.wav',
    'n6.wav',
    'n7.wav',
  ];

  bool isThemeOne = true;
  List<Color> currentColors = [];
  List<String> currentSounds = [];
  AudioPlayer player = AudioPlayer(); // Use AudioPlayer

  @override
  void initState() {
    super.initState();
    // Set default theme
    currentColors = List.from(themeOneColors); // Use List.from to create a new list
    currentSounds = List.from(themeOneSounds); // Use List.from for sounds
  }

  // Function to switch themes
  void switchTheme() {
    setState(() {
      isThemeOne = !isThemeOne;
      currentColors = isThemeOne ? List.from(themeOneColors) : List.from(themeTwoColors);
      currentSounds = isThemeOne ? List.from(themeOneSounds) : List.from(themeTwoSounds);
    });
  }

  // Function to create a key
  Widget buildKey(int index) {
    return XylophoneKey(
      color: currentColors[index],
      sound: currentSounds[index],
      onPressed: () {
        player.play(AssetSource(currentSounds[index])); // Use AssetSource for new audioplayers version
      },
      onChangeTheme: (Color newColor) {
        setState(() {
          currentColors[index] = newColor; // Set the new color
        });
      },
      onChangeSound: (String newSound) {
        setState(() {
          currentSounds[index] = newSound; // Set the new sound
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 50,
              ),
              const SizedBox(width: 7),
              const Text(
                'Xylophone by Zarbaab',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'ComicSans',
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 600, // Increased container width
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100], // Set a different background color
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(8.0), // Padding inside the box
                child: Row(
                  mainAxisSize: MainAxisSize.max, // Use max size for row
                  children: List.generate(7, (index) {
                    return Expanded( // Use Expanded to distribute space evenly
                      child: buildKey(index), // Adjust the key width dynamically
                    );
                  }),
                ),
              ),
              SizedBox(height: 20), // Space between keys and button
              Container(
                child: MouseRegion(
                  onEnter: (_) => setState(() {
                    hoverColor = Colors.purpleAccent;
                  }),
                  onExit: (_) => setState(() {
                    hoverColor = Colors.deepPurpleAccent;
                  }),
                  child: GestureDetector(
                    onTap: switchTheme,
                    child: Container(
                      width: 200,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: hoverColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          'Change Global Theme',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color hoverColor = Colors.deepPurpleAccent; // Default button color
}

class XylophoneKey extends StatelessWidget {
  final Color color; // Color of the key
  final String sound; // Sound file associated with the key
  final VoidCallback onPressed; // Callback function when the key is pressed
  final ValueChanged<Color> onChangeTheme; // Callback to change the key color
  final ValueChanged<String> onChangeSound; // Callback to change the key sound

  XylophoneKey({
    required this.color,
    required this.sound,
    required this.onPressed,
    required this.onChangeTheme,
    required this.onChangeSound,
  });

  // List of available sounds
  final List<String> availableSounds = [
    'n1.wav',
    'note2.wav',
    'note3.wav',
    'note4.wav',
    'note5.wav',
    'note6.wav',
    'note7.wav',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed, // Play the sound
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15), // Round corners
            ),
            margin: EdgeInsets.symmetric(horizontal: 5.0), // Space between keys
            height: 200, // Height of each key
          ),
        ),
        SizedBox(height: 10), // Space between key and color icon
        IconButton(
          icon: Icon(Icons.edit, color: Colors.black), // Pencil icon for color change
          onPressed: () {
            _showColorPicker(context); // Show color picker
          },
        ),
        IconButton(
          icon: Icon(Icons.music_note, color: Colors.black), // Music note icon for sound change
          onPressed: () {
            _showSoundPicker(context); // Show sound picker
          },
        ),
      ],
    );
  }

  // Function to show the color picker dialog
  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        Color selectedColor = color; // Initialize selected color

        return AlertDialog(
          title: Text('Pick a Color'),
          content: SingleChildScrollView(
            child: BlockPicker( // Use BlockPicker for color selection
              pickerColor: selectedColor,
              onColorChanged: (color) {
                selectedColor = color; // Update selected color
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Select'),
              onPressed: () {
                onChangeTheme(selectedColor); // Apply the new color
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Function to show the list of available sounds
  void _showSoundPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select a Sound'),
          content: SingleChildScrollView(
            child: ListBody(
              children: availableSounds.map((sound) {
                return ListTile(
                  title: Text(sound), // Display sound names
                  onTap: () {
                    onChangeSound(sound); // Update the sound
                    Navigator.of(context).pop(); // Close the dialog
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
