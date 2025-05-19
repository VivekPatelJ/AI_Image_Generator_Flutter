part of 'prompt_bloc.dart';

sealed class PromptState {}

final class PromptInitial extends PromptState {}

final class ProptGeneratingImageLoad extends PromptState{

}

final class ProptGeneratingErrorLoad extends PromptState{
  
}

final class ProptGeneratingSuccessLoad extends PromptState{
  final Uint8List uint8list;

  ProptGeneratingSuccessLoad(this.uint8list);
} 