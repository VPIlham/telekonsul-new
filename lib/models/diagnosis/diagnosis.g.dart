// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnosis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Diagnosis _$DiagnosisFromJson(Map<String, dynamic> json) {
  return Diagnosis()
    ..docId = json['doc_id'] as String
    ..dataAntrian = json['data_antrian'] == null
        ? null
        : Antrian.fromJson(json['data_antrian'] as Map<String, dynamic>)
    ..diagnosis = json['diagnosis'] as String
    ..createdAt = Diagnosis._fromJson(json['created_at'] as Timestamp);
}

Map<String, dynamic> _$DiagnosisToJson(Diagnosis instance) => <String, dynamic>{
      'doc_id': instance.docId,
      'data_antrian': instance.dataAntrian,
      'diagnosis': instance.diagnosis,
      'created_at': Diagnosis._toJson(instance.createdAt),
    };
