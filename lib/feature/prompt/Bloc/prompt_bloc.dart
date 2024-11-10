import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/feature/prompt/repos/prompt_repo.dart';
import 'package:meta/meta.dart';

part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptInitial()) {
    on<PromptInitialEvent>(_onPromptInitialEvent);
    on<PromptEnteredEvent>(_onPromptEnteredEvent);
  }

  FutureOr<void> _onPromptEnteredEvent(PromptEnteredEvent event, Emitter<PromptState> emit) async {
    emit(ProptGeneratingImageLoad());

    try {
      Uint8List? bytes = await PromptRepo.generateImage(event.prompt);

      if (bytes != null) {
        emit(ProptGeneratingSuccessLoad(bytes));
      } else {
        log("Image generation returned null. Emitting error state.");
        emit(ProptGeneratingErrorLoad());
      }
    } catch (e) {
      log("Error in generating image: $e");
      emit(ProptGeneratingErrorLoad());
    }
  }

  FutureOr<void> _onPromptInitialEvent(PromptInitialEvent event, Emitter<PromptState> emit) async {
    try {
      Uint8List bytes = await File('Assets/file.png').readAsBytes();
      emit(ProptGeneratingSuccessLoad(bytes));
    } catch (e) {
      log("Error loading initial image: $e");
      emit(ProptGeneratingErrorLoad());
    }
  }
}
