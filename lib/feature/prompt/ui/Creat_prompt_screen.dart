// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/prompt/Bloc/prompt_bloc.dart';
import 'package:flutter_application_1/utils/appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatPromptScreen extends StatefulWidget {
  const CreatPromptScreen({super.key});

  @override
  _CreatPromptScreenState createState() => _CreatPromptScreenState();
}

class _CreatPromptScreenState extends State<CreatPromptScreen> {
  final TextEditingController _controller = TextEditingController();
  final PromptBloc promptBloc = PromptBloc();

  @override
  void initState() {
    promptBloc.add(PromptInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    promptBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(title: 'G E N E R A T I V E   I M A G E'),
      body: BlocConsumer<PromptBloc, PromptState>(
        bloc: promptBloc,
        listener: (context, state) {
          if (state is ProptGeneratingErrorLoad) {
            // Show a Snackbar or any other error handling logic
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: Could not generate the image")),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ProptGeneratingImageLoad:
              return Center(child: CircularProgressIndicator());

            case ProptGeneratingErrorLoad:
              return Center(child: Text("Something went wrong"));

            case ProptGeneratingSuccessLoad:
              final successState = state as ProptGeneratingSuccessLoad;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(successState.uint8list),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 300,
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        TextField(
                          controller: _controller,
                          cursorColor: Colors.deepPurple,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "Enter Prompt",
                            hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green.shade800),
                            ),
                            onPressed: () {
                              if (_controller.text.isNotEmpty) {
                                promptBloc.add(
                                  PromptEnteredEvent(prompt: _controller.text),
                                );
                              }
                            },
                            icon: Icon(
                              Icons.generating_tokens,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Generate",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: ElevatedButton.icon(
                              onPressed: () {},
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                              icon: Icon(
                                Icons.download,
                                color: Colors.white,
                              ),
                              label: Text("Download", style: TextStyle(color: Colors.white),)),
                        )
                      ],
                    ),
                  ),
                ],
              );

            default:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Enter a prompt to generate an image",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _controller,
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                        hintText: "Type your prompt here...",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.deepPurple),
                        ),
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            promptBloc.add(
                              PromptEnteredEvent(prompt: _controller.text),
                            );
                          }
                        },
                        icon: Icon(Icons.generating_tokens),
                        label: Text("Generate"),
                      ),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
