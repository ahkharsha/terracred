import 'dart:io';
import 'package:terracred/multi-language/classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:terracred/const/constants.dart';

class ImageChat extends StatefulWidget {
  const ImageChat({
    super.key,
  });

  @override
  State<ImageChat> createState() => _ImageChatState();
}

class _ImageChatState extends State<ImageChat> {
  bool loading = false;
  List textAndImageChat = [];
  List textWithImageChat = [];
  File? imageFile;

  final ImagePicker picker = ImagePicker();

  final TextEditingController _textController = TextEditingController();
  final ScrollController _controller = ScrollController();

  final gemini = GoogleGemini(
    apiKey: apiKey,
  );

  void fromTextAndImage(
      {required String query, required File image, required String prompt}) {
    setState(() {
      loading = true;
      textAndImageChat.add({
        "role": translation(context).me,
        "text": query,
        "image": image,
        "avatar": "Me",
      });
      _textController.clear();
      imageFile = null;
    });
    scrollToTheEnd();

    gemini
        .generateFromTextAndImages(query: prompt + " " + query, image: image)
        .then((value) {
      setState(() {
        loading = false;
        textAndImageChat.add({
          "role": translation(context).aiDoc,
          "text": value.text,
          "image": "",
          "avatar": "AI",
        });
      });
      scrollToTheEnd();
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
        textAndImageChat.add({
          "role": translation(context).aiDoc,
          "text": error.toString(),
          "image": "",
          "avatar": "AI",
        });
      });
      scrollToTheEnd();
    });
  }

  void scrollToTheEnd() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: textAndImageChat.length,
              padding: const EdgeInsets.only(bottom: 20),
              itemBuilder: (context, index) {
                return ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    child:
                        Text(textAndImageChat[index]["avatar"].substring(0, 2)),
                  ),
                  title: Text(textAndImageChat[index]["role"]),
                  subtitle: Text(textAndImageChat[index]["text"]),
                  trailing: textAndImageChat[index]["image"] == ""
                      ? null
                      : Image.file(
                          textAndImageChat[index]["image"],
                          width: 90,
                        ),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: textColor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: translation(context).typeMessage,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                      fillColor: Colors.transparent,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add_a_photo,
                    color: Color.fromARGB(255, 93, 11, 82),
                  ),
                  onPressed: () async {
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      imageFile = image != null ? File(image.path) : null;
                    });
                  },
                ),
                IconButton(
                  icon: loading
                      ? const CircularProgressIndicator()
                      : const Icon(
                          Icons.send,
                          color: Color.fromARGB(255, 93, 11, 82),
                        ),
                  onPressed: () {
                    if (imageFile == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please select an image")));
                      return;
                    }
                    fromTextAndImage(
                        image: imageFile!,
                        prompt:
                            "Consider yourself as a sustainability specialist. I am a general person interested to work on sustainability, only answer question related to sustainability. If the question by me is not related to sustainability, politely say you don't know the answers for questions which are not related to sustainability, and request them to ask something related to sustainability. Make sure you are always polite, patient, gentle and understanding of me. Ask me follow up questions if you need more info about me. Talk to me in a friendly manner. Please don't repeat my question while answering it. Answer my questions in under 45 words. Don't highlight your answers in bold or asterisk. My question is as follows:",
                        query: _textController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: imageFile != null
          ? Container(
              margin: const EdgeInsets.only(bottom: 80),
              height: 150,
              child: Image.file(imageFile ?? File("")),
            )
          : null,
    );
  }
}
