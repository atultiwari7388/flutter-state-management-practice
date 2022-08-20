import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechView extends StatefulWidget {
  const TextToSpeechView({Key? key}) : super(key: key);

  @override
  State<TextToSpeechView> createState() => _TextToSpeechViewState();
}

class _TextToSpeechViewState extends State<TextToSpeechView> {
  final TextEditingController _controller = TextEditingController();
  bool isPlaying = false;
  final _flutterTTS = FlutterTts();

  void initializeTTS() {
    //starting
    _flutterTTS.setStartHandler(() {
      setState(() {
        isPlaying = true;
      });
    });

    //complete
    _flutterTTS.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });

    //error
    _flutterTTS.setErrorHandler((message) {
      setState(() {
        isPlaying = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeTTS();
  }

  void speak() async {
    if (_controller.text.isNotEmpty) {
      await _flutterTTS.speak(_controller.text.toString());
    }
  }

  void stop() async {
    await _flutterTTS.stop();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _flutterTTS.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text to Speech Converter"),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            width: double.maxFinite,
            child: TextField(
              controller: _controller,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => isPlaying ? stop() : speak(),
            child: Text(isPlaying ? "Stop" : "Bol na"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _controller.text = "";
              });
            },
            child: const Text("Reset"),
          )
        ],
      ),
    );
  }
}
