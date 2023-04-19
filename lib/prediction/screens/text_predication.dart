import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';

class TextPrediction extends StatefulWidget {
  const TextPrediction({super.key});

  @override
  State<TextPrediction> createState() => _TextPredictionState();
}

class _TextPredictionState extends State<TextPrediction> {
  late OpenAI openAI;
  String token = "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";
  final _textController = TextEditingController();
  String answer = '';
  @override
  void initState() {
    super.initState();
    openAI = OpenAI.instance.build(
      token: token,
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
    );
    _textController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: _textController,
          decoration: const InputDecoration(
            labelText: 'Enter the question',
          ),
        ),
        Text('answer:$answer'),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () async {
            answer = '';
            setState(() {});
            final request = CompleteText(
                prompt: _textController.text,
                model: Model.textDavinci3,
                maxTokens: 400);

            final response = await openAI.onCompletion(request: request);
            answer = (response?.choices.first.text).toString();
            setState(() {});
          },
          child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(12)),
              child: const Text('Get Answer')),
        )
      ],
    );
  }
}
