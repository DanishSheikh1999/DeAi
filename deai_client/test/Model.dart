import 'dart:convert';

import 'package:collection/collection.dart';

class Model {
  final List<String> classifications;
  final String type;
  final List<double> weights;
  final double intercept;
  final double learningRate;
  Model({
    required this.classifications,
    required this.type,
    required this.weights,
    required this.intercept,
    required this.learningRate,
  });


  Model copyWith({
    List<String>? classifications,
    String? type,
    List<double>? weights,
    double? intercept,
    double? learningRate,
  }) {
    return Model(
      classifications: classifications ?? this.classifications,
      type: type ?? this.type,
      weights: weights ?? this.weights,
      intercept: intercept ?? this.intercept,
      learningRate: learningRate ?? this.learningRate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'classifications': classifications,
      'type': type,
      'weights': weights,
      'intercept': intercept,
      'learningRate': learningRate,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      classifications: List<String>.from(map['classifications']),
      type: map['type'],
      weights: List<double>.from(map['weights']),
      intercept: map['intercept'],
      learningRate: map['learningRate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Model.fromJson(String source) => Model.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Model(classifications: $classifications, type: $type, weights: $weights, intercept: $intercept, learningRate: $learningRate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is Model &&
      listEquals(other.classifications, classifications) &&
      other.type == type &&
      listEquals(other.weights, weights) &&
      other.intercept == intercept &&
      other.learningRate == learningRate;
  }

  @override
  int get hashCode {
    return classifications.hashCode ^
      type.hashCode ^
      weights.hashCode ^
      intercept.hashCode ^
      learningRate.hashCode;
  }
}

