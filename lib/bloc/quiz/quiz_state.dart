import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class QuizState extends Equatable {
  final double currentScore;
  final int currentIndex;
  final int currentAttempts;
  final int currentWrongAttempts;
  final int currentCorrectAttempts;

  const QuizState(this.currentScore, this.currentIndex, this.currentAttempts, this.currentWrongAttempts, this.currentCorrectAttempts);

  @override
  List<Object?> get props => [currentIndex];
}

class QuizOnGoingState extends QuizState {
  final dynamic currentQuestion;
  final dynamic options;

  const QuizOnGoingState(super.currentScore, super.currentIndex, super.currentAttempts, super.currentWrongAttempts, super.currentCorrectAttempts, this.currentQuestion, this.options);

  @override
  List<Object?> get props => [currentQuestion];
}

class QuizFinishedState extends QuizState {
  const QuizFinishedState(super.currentScore, super.currentIndex, super.currentAttempts, super.currentWrongAttempts, super.currentCorrectAttempts);
}
