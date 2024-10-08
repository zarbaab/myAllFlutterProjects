import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const SpinBottleGame());
}

class SpinBottleGame extends StatelessWidget {
  const SpinBottleGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpinBottleHome(),
    );
  }
}

class SpinBottleHome extends StatefulWidget {
  const SpinBottleHome({super.key});

  @override
  _SpinBottleHomeState createState() => _SpinBottleHomeState();
}

class _SpinBottleHomeState extends State<SpinBottleHome>
    with SingleTickerProviderStateMixin {
  final List<Color> playerColors = [
    Colors.redAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.yellowAccent,
    Colors.purpleAccent,
    Colors.orangeAccent,
    Colors.tealAccent,
    Colors.deepOrangeAccent,
    Colors.cyanAccent,
    Colors.indigoAccent,
  ];

  List<String> playerNames =
      List.generate(10, (index) => "Player ${index + 1}");
  bool spinning = false;
  String selectedPlayer = "";
  bool showNameInput = true;
  String selectedBottleImage =
      'assets/images/bottle_1.png'; // Default bottle image

  AnimationController? _controller;
  double _currentRotation = 0;
  double _targetRotation = 0;

  // Predefined challenges
  List<String> challenges = [
    "Balance on one foot for 30 seconds",
    "Make up a funny story in 1 minute",
    "Do your best superhero pose",
    "Mimic a famous movie scene",
    "Try to juggle 3 objects",
    "Make animal noises for 20 seconds",
    "Try to rhyme every word you say for 1 minute",
    "Do a dramatic reading of a random text message",
    "Walk like a crab for 30 seconds",
    "Hold a plank position for 20 seconds"
  ];

  String selectedChallenge = "";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {
          _currentRotation = _controller!.value * _targetRotation;
        });
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (spinning) {
      return false; // Prevent back navigation if spinning
    } else {
      return true; // Allow back navigation if not spinning
    }
  }

  void spinBottle() {
    setState(() {
      spinning = true;

      double playerAngle = (2 * pi) / playerNames.length;
      Random random = Random();
      int selectedPlayerIndex = random.nextInt(playerNames.length);
      double stopAngle = selectedPlayerIndex * playerAngle;

      _targetRotation =
          _currentRotation + 4 * pi + stopAngle - _currentRotation % (2 * pi);

      _controller?.reset();
      _controller?.forward().then((value) {
        setState(() {
          spinning = false;
          selectedPlayer = playerNames[selectedPlayerIndex];
          selectedChallenge = challenges[random.nextInt(challenges.length)];
        });
      });
    });
  }

  Widget buildPlayerNames() {
    return ListView.builder(
      itemCount: playerNames.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: TextField(
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              filled: true,
              fillColor:
                  const Color.fromARGB(255, 241, 237, 241).withOpacity(0.9),
              labelText: "Player ${index + 1} Name",
              labelStyle: const TextStyle(
                color: Color.fromARGB(255, 116, 20, 95),
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 116, 20, 95), width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 157, 65, 175), width: 3),
              ),
            ),
            onChanged: (value) {
              playerNames[index] =
                  value.isNotEmpty ? value : "Player ${index + 1}";
            },
          ),
        );
      },
    );
  }

  Widget buildWheel() {
    return Stack(
      alignment: Alignment.center,
      children: List.generate(playerNames.length, (index) {
        final angle = (index / playerNames.length) * 2 * pi;
        return Transform.translate(
          offset: Offset(
            120 * cos(angle),
            120 * sin(angle),
          ),
          child: CircleAvatar(
            radius: 40,
            backgroundColor: playerColors[index % playerColors.length],
            child: Text(
              playerNames[index],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }),
    );
  }

  void selectBottle() async {
    String? selected = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select a Bottle"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  leading: Image.asset('assets/images/bottle_1.png',
                      width: 50, height: 50),
                  title: const Text("Wine Bottle"),
                  onTap: () {
                    Navigator.of(context).pop('assets/images/bottle_1.png');
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/images/bottle_2.png',
                      width: 50, height: 50),
                  title: const Text("Green Bottle"),
                  onTap: () {
                    Navigator.of(context).pop('assets/images/bottle_2.png');
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/images/bottle_3.png',
                      width: 50, height: 50),
                  title: const Text("Black Bottle"),
                  onTap: () {
                    Navigator.of(context).pop('assets/images/bottle_3.png');
                  },
                ),
                ListTile(
                  leading:
                      Image.asset('assets/images/d.png', width: 50, height: 50),
                  title: const Text("Milk Bottle"),
                  onTap: () {
                    Navigator.of(context).pop('assets/images/d.png');
                  },
                ),
                ListTile(
                  leading:
                      Image.asset('assets/images/s.png', width: 50, height: 50),
                  title: const Text("Juice Bottle"),
                  onTap: () {
                    Navigator.of(context).pop('assets/images/s.png');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null) {
      setState(() {
        selectedBottleImage = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 116, 20, 95),
          elevation: 10,
          shadowColor: Color.fromARGB(255, 157, 65, 175),
          title: const Text(
            "Spin the Bottle Game",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 116, 20, 95), Colors.pink.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: showNameInput
                    ? buildPlayerNamePage()
                    : buildSpinBottlePage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPlayerNamePage() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: buildPlayerNames(),
              ),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Color.fromARGB(255, 116, 20, 95),
              elevation: 10),
          onPressed: () {
            setState(() {
              showNameInput = false;
            });
          },
          child: const Text(
            "Start the Game",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSpinBottlePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Align to center vertically
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: selectBottle,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Color.fromARGB(255, 157, 65, 175),
            ),
            child: const Text(
              "Select Bottle",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: _currentRotation,
                  child: Image.asset(
                    selectedBottleImage,
                    width: 150,
                    height: 150,
                  ),
                ),
                buildWheel(), // Displays the players around the spinning bottle
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        if (selectedChallenge.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Challenge: $selectedChallenge",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Color.fromARGB(255, 116, 20, 95),
            elevation: 10,
            shadowColor: Color.fromARGB(255, 157, 65, 175),
            textStyle:
                const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          onPressed: spinning ? null : spinBottle,
          child: Text(
            spinning ? "Spinning..." : "Spin the Bottle",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
