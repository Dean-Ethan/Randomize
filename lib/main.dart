import 'package:flutter/material.dart';
import 'dart:math';
import 'package:randomize/info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Randomize!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 89, 255),
        ),
      ),
      home: const Main(title: 'Randomize!'),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key, required this.title});

  final String title;

  @override
  State<Main> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Main> {
  String message1 = "No items in array!";
  String message2 = "";
  List<String> items = [];
  final TextEditingController _controller = TextEditingController();

  void randomize() {
    final random = Random();
    String selectedWord = items[random.nextInt(items.length)];

    setState(() {
      message2 = "Randomly selected task: $selectedWord";
    });
  }

  void showError(String error) {
    switch (error) {
      case "failedInput":
        debugPrint("Error: You have to enter something!");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text('You have to enter something!')),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),

                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ],
            ),
          ),
        );

        break;
      case "failedRandomize":
        debugPrint("Error: You must have added at least 2 tasks to randomize!");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text('You must have added at least 2 tasks to randomize!')),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),

                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ],
            ),
          ),
        );

        break;
      case "alreadyExists":
        debugPrint("Error: This item already exists!");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("This item already exists!")),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),

                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                )
              ]
            ),
          )
        );
    }
  }

  void showInfo(String info) {
    switch (info) {
      case "noItems":
        debugPrint("Info: The array is empty!");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text('The list is empty.')),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),

                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ],
            ),
          ),
        );

        break;
    }
  }

  void activateRandomize() {
    if (items.isEmpty || items.length == 1) {
      showError("failedRandomize");
    } else {
      for (int i = 0; i < 3; i++) {
        randomize();
      }
    }
  }

  void add(String text) {
    if (text.trim().isEmpty) {
      showError("failedInput");
      return;
    }

    // Delete this block if you don't want to be limited to adding only one entry.
    if (items.contains(text.trim())) {
      showError("alreadyExists");
      _controller.clear();
      return;
    }

    if (message1 == "No items in array!") {
      message1 = "";
    }

    setState(() {
      items.add(text.trim());
      message1 += "\n- ${text.trim()}";
      _controller.clear();
    });
  }

  void clearArray() {
    if (items.isNotEmpty) {
      items.clear();

      setState(() {
        message1 = "No items in array!";
      });
    } else {
      showInfo("noItems");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),

        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.indigo,
                Colors.purple,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Add an item...",
                        ),
                        controller: _controller,
                        onSubmitted: add,
                      )
                    ),  
                    SizedBox(width: 15)
                  ]  
                ),  
                SizedBox(height: 12),
                Text(message1),
                SizedBox(height: 24),
                ElevatedButton(onPressed: activateRandomize, child: Text("Randomize!")),
                SizedBox(height: 12),
                ElevatedButton(onPressed: clearArray, child: Text("Clear list")),
                SizedBox(height: 12),
                Text(message2),
                SizedBox(height: 80)
              ],
            )
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(left: 10, right: 0, bottom: 0, top: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Version: 2.0.0"),

            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => AppInfo()));
              },

              icon: Icon(Icons.info)
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => add(_controller.text),
        tooltip: 'Add task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
