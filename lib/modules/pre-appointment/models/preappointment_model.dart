import 'package:equatable/equatable.dart';

class PreAppointmentModel extends Equatable {
  final int errorCode;
  final String responseCode;
  final String message;
  final PreAppointmentData data;

  const PreAppointmentModel({
    required this.errorCode,
    required this.responseCode,
    required this.message,
    required this.data,
  });

  factory PreAppointmentModel.fromJson(Map<String, dynamic> json) {
    return PreAppointmentModel(
      errorCode: int.tryParse(json['error_code']?.toString() ?? '') ?? 0,
      responseCode: json['response_code']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      data: PreAppointmentData.fromJson(
        json['data'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [errorCode, responseCode, message, data];
}

class PreAppointmentData extends Equatable {
  final List<Visitor> visitor;
  final List<Vendor> vendor;
  final List<ContractEmployee> contractEmployee;
  final int totalCount;

  const PreAppointmentData({
    required this.visitor,
    required this.vendor,
    required this.contractEmployee,
    required this.totalCount,
  });

  factory PreAppointmentData.fromJson(Map<String, dynamic> json) {
    return PreAppointmentData(
      visitor:
          (json['visitor'] as List<dynamic>?)
              ?.map((e) => Visitor.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      vendor:
          (json['vendor'] as List<dynamic>?)
              ?.map((e) => Vendor.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      contractEmployee:
          (json['contractual_employee'] as List<dynamic>?)
              ?.map((e) => ContractEmployee.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalCount: json['total_count'] ?? 0,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [visitor, vendor, contractEmployee, totalCount];
}

class Visitor extends Equatable {
  final String guestId;
  final String guestTitle;
  final String guestName;
  final String guestMobile;
  final String guestEmail;
  final int status;
  final bool mainGuestVerificationStatus;
  final int mainGuestVerificationRequired;
  final int accompanyGuestVeriRequired;
  final String ePassStatus;
  final String profileUrl;
  final String fromDate;
  final String toDate;
  final String fromTime;
  final String toTime;
  final String meetingWith;
  final bool ambiguityStatus;
  final String? ePassCode;
  final int accompanyGuestCount;
  final String? dutyPostId;
  final String overallVerificationStatus;
  final bool guestProfileUrlPresent;
  final int paidBy;
  final int visitingChargeApplicable;
  final int visitingAmount;
  final int mainGuestPicture;
  final int ePassGenerationType;
  final int ePassSendTo;
  final int dailyEntryPermitted;
  final int dailyEntryCount;
  final List<AccompanyGuest> accompanyGuest;

  const Visitor({
    required this.guestId,
    required this.guestTitle,
    required this.guestName,
    required this.guestMobile,
    required this.guestEmail,
    required this.status,
    required this.mainGuestVerificationStatus,
    required this.mainGuestVerificationRequired,
    required this.accompanyGuestVeriRequired,
    required this.ePassStatus,
    required this.profileUrl,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    required this.meetingWith,
    required this.ambiguityStatus,
    this.ePassCode,
    required this.accompanyGuestCount,
    this.dutyPostId,
    required this.overallVerificationStatus,
    required this.guestProfileUrlPresent,
    required this.paidBy,
    required this.visitingChargeApplicable,
    required this.visitingAmount,
    required this.mainGuestPicture,
    required this.ePassGenerationType,
    required this.ePassSendTo,
    required this.dailyEntryPermitted,
    required this.dailyEntryCount,
    required this.accompanyGuest,
  });

  factory Visitor.fromJson(Map<String, dynamic> json) {
    return Visitor(
      guestId: json['guest_id']?.toString() ?? '',
      guestTitle: json['guest_title']?.toString() ?? '',
      guestName: json['guest_name']?.toString() ?? '',
      guestMobile: json['guest_mobile']?.toString() ?? '',
      guestEmail: json['guest_email']?.toString() ?? '',
      status: json['status'] ?? 0,
      mainGuestVerificationStatus:
          json['main_guest_verification_status'] ?? false,
      mainGuestVerificationRequired:
          json['main_guest_verification_required'] ?? 0,
      accompanyGuestVeriRequired:
          json['accompanying_guest_verification_required'] ?? 0,
      ePassStatus: json['e_pass_status']?.toString() ?? '',
      profileUrl: json['profile_url']?.toString() ?? '',
      fromDate: json['from_date']?.toString() ?? '',
      toDate: json['to_date']?.toString() ?? '',
      fromTime: json['from_time']?.toString() ?? '',
      toTime: json['to_time']?.toString() ?? '',
      meetingWith: json['meeting_with']?.toString() ?? '',
      ambiguityStatus: json['ambiguity_status'] ?? false,
      ePassCode: json['e_pass_code']?.toString(),
      accompanyGuestCount: json['accompanying_guests_count'] ?? 0,
      dutyPostId: json['duty_post_id']?.toString(),
      overallVerificationStatus:
          json['overall_verification_status']?.toString() ?? '',
      guestProfileUrlPresent: json['guest_profile_url_present'] ?? false,
      paidBy: json['paid_by'] ?? 0,
      visitingChargeApplicable: json['visiting_charge_applicable'] ?? 0,
      visitingAmount: json['visting_amount'] ?? 0,
      mainGuestPicture: json['main_guest_picture'] ?? 0,
      ePassGenerationType: json['e_pass_generation_type'] ?? 0,
      ePassSendTo: json['e_pass_send_to'] ?? 0,
      dailyEntryPermitted: json['daily_entry_permitted'] ?? 0,
      dailyEntryCount: json['daily_entry_count'] ?? 0,
      accompanyGuest:
          (json['accompanying_guests'] as List<dynamic>?)
              ?.map((e) => AccompanyGuest.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    guestId,
    guestTitle,
    guestName,
    guestMobile,
    guestEmail,
    status,
    mainGuestVerificationStatus,
    mainGuestVerificationRequired,
    accompanyGuestVeriRequired,
    ePassStatus,
    profileUrl,
    fromDate,
    toDate,
    fromTime,
    toTime,
    meetingWith,
    ambiguityStatus,
    ePassCode,
    accompanyGuestCount,
    dutyPostId,
    overallVerificationStatus,
    guestProfileUrlPresent,
    paidBy,
    visitingChargeApplicable,
    visitingAmount,
    mainGuestPicture,
    ePassGenerationType,
    ePassSendTo,
    dailyEntryPermitted,
    dailyEntryCount,
    accompanyGuest,
  ];
}

class AccompanyGuest extends Equatable {
  final String guestId;
  final String name;
  final String mobile;
  final bool verificationStatus;
  final String profileUrl;
  final String? ePassCode;

  const AccompanyGuest({
    required this.guestId,
    required this.name,
    required this.mobile,
    required this.verificationStatus,
    required this.profileUrl,
    this.ePassCode,
  });

  factory AccompanyGuest.fromJson(Map<String, dynamic> json) {
    return AccompanyGuest(
      guestId: json['guest_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      mobile: json['mobile']?.toString() ?? '',
      verificationStatus: json['verification_status'] ?? false,
      profileUrl: json['profile_url']?.toString() ?? '',
      ePassCode: json['e_pass_code']?.toString(),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    guestId,
    name,
    mobile,
    verificationStatus,
    profileUrl,
    ePassCode,
  ];
}
