import 'dart:convert';

class LawyerAppointment {
  final String appointmentId;
  final String appointmentTitle;
  final DateTime appointmentDate;
  String appointmentStatus;
  final String clientId;
  final DateTime createdAt;
  final String lawyerId;

  LawyerAppointment({
    required this.appointmentId,
    required this.appointmentTitle,
    required this.appointmentDate,
    required this.appointmentStatus,
    required this.clientId,
    required this.createdAt,
    required this.lawyerId,
  });

  factory LawyerAppointment.fromJson(Map<String, dynamic> json) {
    return LawyerAppointment(
      appointmentId: json['appointment_id'] ?? '',
      appointmentTitle: json['appointment_title'] ?? '',
      appointmentDate: json['appointment_date'] != null
          ? DateTime.parse(json['appointment_date'].split('.').first)
          : DateTime.now(),
      appointmentStatus: json['appointment_status'] ?? '',
      clientId: json['client_id'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'].split('.').first)
          : DateTime.now(),
      lawyerId: json['lawyer_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointment_id': appointmentId,
      'appointment_title': appointmentTitle,
      'appointment_date': appointmentDate.toIso8601String(),
      'appointment_status': appointmentStatus,
      'client_id': clientId,
      'created_at': createdAt.toIso8601String(),
      'lawyer_id': lawyerId,
    };
  }
}
