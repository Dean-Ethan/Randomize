import 'package:flutter/material.dart';
import 'package:randomize/main.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Randomize!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 89, 255),
        ),
      ),
      home: const Info(title: 'Randomize!'),
    );
  }
}

class Info extends StatefulWidget {
  const Info({super.key, required this.title});

  final String title;

  @override
  State<Info> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Info> {

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

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Randomize!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(height: 8),
                Text("Author: Dean"),
                SizedBox(height: 8),
                Text("Version: 2.0.0"),
                SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyApp()), (Route<dynamic> route) => false);
                  },
                  
                  child: Text("Back")
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
