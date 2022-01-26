import 'package:flutter/material.dart';
import 'package:speach_app/shared/components/components.dart';
import 'package:speach_app/shared/components/constants.dart';
import 'package:text_to_speech/text_to_speech.dart';

class TTSScreen extends StatefulWidget {
  const TTSScreen({Key? key}) : super(key: key);

  @override
  _TTSScreenState createState() => _TTSScreenState();
}

class _TTSScreenState extends State<TTSScreen> {
  TextToSpeech tts = TextToSpeech();
  var textController = TextEditingController();

  String _localId = 'ar';
  final Languages _lang = Languages.ar;
  final List<PopupMenuEntry<Languages>> _items = <PopupMenuEntry<Languages>>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (Languages lang in Languages.values) {
      _items.add(PopupMenuItem(
        child: Text(
          lang == Languages.ar ? 'Arabic' : 'English',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        value: lang,
      ));
    }
    tts.setPitch(2);
    tts.setRate(2);
    tts.setVolume(1);
    tts.getLanguages().then((value) {
      print(value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25.0,
            ),
            Row(
              children: [
                Expanded(
                  child: defaultTextFormField(
                    hint: "Enter Text",
                    prefixIcon: Icons.text_fields_outlined,
                    context: context,
                    type: TextInputType.text,
                    validator: (value) {},
                    controller: textController,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return _items;
                  },
                  onSelected: (value) {
                    if (value == Languages.ar) {
                      setState(() {
                        _localId = 'ar';
                      });
                    } else {
                      setState(() {
                        _localId = 'en';
                      });
                    }
                    print('Local ID : $_localId');
                  },
                  child: const Icon(
                    Icons.language,
                    size: 35.0,
                  ),
                  tooltip: 'Select Language',
                  elevation: 10.0,
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            defaultButton(
              function: () {
                tts.setLanguage(_localId);
                tts.speak(textController.text);
              },
              text: _localId == 'en' ? 'Start' : 'ابدأ',
              background: Colors.blueGrey.shade700,
            ),
            const SizedBox(
              height: 20.0,
            ),
            defaultButton(
              function: () {
                tts.stop();
              },
              text: _localId == 'en' ? 'Stop' : 'توقف',
              background: Colors.blueGrey.shade700,
            ),
          ],
        ),
      ),
    );
  }
}
