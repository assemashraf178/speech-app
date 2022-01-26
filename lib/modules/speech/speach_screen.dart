import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:speach_app/shared/components/constants.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final translator = GoogleTranslator();
  final SpeechToText _speech = SpeechToText();
  String _allText = '';
  String _textTranslated = '';
  String _text = '';
  String _localId = 'ar';
  final Languages _lang = Languages.ar;
  final List<PopupMenuEntry<Languages>> _items = <PopupMenuEntry<Languages>>[];
  double _soundLevel = 0.0;

  @override
  void initState() {
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
    setState(() {});
  }

  void _startListening() async {
    bool available = await _speech.initialize(onStatus: (String value) async {
      print('onStatus : $value');
      setState(() {});
    });
    if (available) {
      await _speech.listen(
        onResult: _onSpeechResult,
        localeId: _localId,
        sampleRate: 100.0,
        listenFor: const Duration(minutes: 5),
        pauseFor: const Duration(minutes: 5),
        cancelOnError: true,
        listenMode: ListenMode.deviceDefault,
        onSoundLevelChange: (level) {
          _soundLevel = level;
          setState(() {});
        },
      );
    }
    print('Start');
    setState(() {});
  }

  void _stopListening() async {
    await _speech.stop();
    print('Stop');
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _text = result.recognizedWords;
    });
    _localId == 'ar'
        ? translator.translate(_text, from: 'ar', to: 'en').then((value) {
            setState(() {
              _textTranslated = value.text;
            });
          })
        : translator.translate(_text, from: 'en', to: 'ar').then((value) {
            setState(() {
              _textTranslated = value.text;
            });
          });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _stopListening();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AvatarGlow(
            endRadius: size.width / 5.0,
            shape: BoxShape.circle,
            repeat: true,
            animate: !_speech.isNotListening,
            glowColor: Colors.grey,
            showTwoGlows: true,
            child: FloatingActionButton(
              tooltip: _localId == 'ar' ? 'اضغط للتحدث' : 'Click to speech',
              backgroundColor: Colors.grey[400],
              onPressed: () {
                print(_speech.isNotListening);
                if (_speech.isNotListening) {
                  _startListening();
                }
              },
              elevation: size.width / 20.0,
              child: Icon(
                !_speech.isNotListening ? Icons.mic : Icons.mic_off,
                color: const Color(0xff1C262F),
              ),
            ),
          ),
          if (!_speech.isNotListening)
            FloatingActionButton(
              onPressed: _stopListening,
              child: const Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              backgroundColor: Colors.red.shade900,
            ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(
          size.height / 80.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: _localId == 'en'
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Spacer(),
                  Text(
                    _localId == 'en'
                        ? 'Sound Level : ${_soundLevel.round()}'
                        : 'مستوى الصوت : ${_soundLevel.round()}',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                  ),
                  const Spacer(),
                  PopupMenuButton(
                    // initialValue: Languages.ar,
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
                      size: 24.0,
                    ),
                    tooltip: 'Select Language',
                    elevation: 10.0,
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(
                    size.height / 40.0,
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: _localId == 'en'
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Text(
                        _localId == 'en' ? 'Current text : ' : ' : النص الحالي',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                      ),
                      Text(
                        _text,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                      ),
                      SizedBox(
                        height: size.height / 80.0,
                      ),
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (_text != '') {
                                  _allText += '\n' + _text;
                                }
                                _text = '';
                              });
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            tooltip: _localId == 'en'
                                ? 'Add text to all'
                                : 'اضافة النص الحالي للكل',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(
                    size.height / 40.0,
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: _localId == 'en'
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (_allText != '' || _textTranslated != '') {
                                Share.share(
                                  "All Text: $_allText\nTranslated Text:  $_textTranslated",
                                );
                              }
                            },
                            icon: const Icon(
                              Icons.share,
                            ),
                            tooltip:
                                _localId == 'ar' ? 'مشاركة النص' : 'share text',
                          ),
                          IconButton(
                            onPressed: () {
                              if (_allText != '' || _textTranslated != '') {
                                FlutterClipboard.copy(
                                  "All Text: $_allText\nTranslated Text:  $_textTranslated",
                                ).then((value) {
                                  Fluttertoast.showToast(
                                    msg: _localId == 'en'
                                        ? 'Copy Successfully'
                                        : 'تم النسخ بنجاح',
                                    backgroundColor: Colors.blue,
                                  );
                                });
                              } else {
                                Fluttertoast.showToast(
                                  msg: _localId == 'en'
                                      ? 'Not found text'
                                      : 'لا يوجد اي نص',
                                  backgroundColor: Colors.red,
                                );
                              }
                            },
                            icon: const Icon(
                              Icons.copy_all,
                            ),
                            tooltip:
                                _localId == 'ar' ? 'نسخ النص' : 'copy text',
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _allText = '';
                                _textTranslated = '';
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                            ),
                            tooltip:
                                _localId == 'ar' ? 'مسح النص' : 'delete text',
                          ),
                        ],
                      ),
                      Text(
                        _localId == 'en' ? 'Total text :' : ' : النص الكامل',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                      ),
                      Text(
                        _allText.toString(),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Column(
                        children: [
                          Align(
                            child: Text(
                              _localId == 'en' ? 'Translate :' : ' : الترجمة',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                            ),
                            alignment: _localId == 'en'
                                ? AlignmentDirectional.centerStart
                                : AlignmentDirectional.centerEnd,
                          ),
                          Align(
                            child: Text(
                              _textTranslated,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                            ),
                            alignment: _localId == 'en'
                                ? AlignmentDirectional.centerEnd
                                : AlignmentDirectional.centerStart,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
