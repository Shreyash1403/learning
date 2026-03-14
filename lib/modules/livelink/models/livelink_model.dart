import 'package:equatable/equatable.dart';

// ======================================================================
// LIVELINK USER MODEL
// ======================================================================
// Represents ONE user from the "user_data_array" in the API response
//
// Sample JSON for one user:
// {
//     "end_user_id": "LVU-00001",
//     "name": "Shreyash",
//     "contactNo": "8421100891",
//     "emailId": "shreyashkale1403@gmail.com",
//     "entityName": "Student",
//     "selectedVerifications": "DVF-00002",
//     "createdOn": "2026-02-17 00:15:15",
//     "paymentFrom": "1",
//     "livelink_type": "1",
//     "paid_by": "",
//     "linkExpiredDays": "2",
//     "statusType": "Active",
//     "linkOpendedOn": "0000-00-00 00:00:00",
//     "linkSentOn": "W,S,E",
//     "ambiguityFoundIn": "No",
//     "ambiguityData": []
// }
//
// DECISION FOR EACH FIELD:
// ┌──────────────────────┬──────────────┬──────────────────────────────────┐
// │ Field                │ Type         │ Why?                             │
// ├──────────────────────┼──────────────┼──────────────────────────────────┤
// │ endUserId            │ String       │ Always show ID on card           │
// │ name                 │ String       │ Always show name                 │
// │ contactNo            │ String       │ Always show contact              │
// │ emailId              │ String       │ Always show email                │
// │ entityName           │ String       │ Always show entity               │
// │ selectedVerifications│ String       │ Always show                      │
// │ createdOn            │ String       │ Always show date                 │
// │ paymentFrom          │ String       │ Always show                      │
// │ livelinkType         │ String       │ Always show                      │
// │ paidBy               │ String?      │ HIDE "Paid by" if empty/null     │
// │ linkExpiredDays      │ String       │ Always show                      │
// │ statusType           │ String       │ Always show status badge         │
// │ linkOpenedOn         │ String?      │ HIDE if "0000-00-00" or null     │
// │ linkSentOn           │ String       │ Always show (W,S,E)              │
// │ ambiguityFoundIn     │ String       │ Always show                      │
// │ ambiguityData        │ List<dynamic>│ Always show (empty = no data)    │
// └──────────────────────┴──────────────┴──────────────────────────────────┘
// ======================================================================

class LiveLinkUser extends Equatable {
  final String endUserId;
  final String name;
  final String contactNo;
  final String emailId;
  final String entityName;
  final String selectedVerifications;
  final String createdOn;
  final String paymentFrom;
  final String livelinkType;
  final String? paidBy; // Nullable: hide "Paid by" section if null/empty
  final String linkExpiredDays;
  final String statusType;
  final String? linkOpenedOn; // Nullable: hide if never opened ("0000-00-00")
  final String linkSentOn;
  final String ambiguityFoundIn;
  final List<dynamic> ambiguityData;

  const LiveLinkUser({
    required this.endUserId,
    required this.name,
    required this.contactNo,
    required this.emailId,
    required this.entityName,
    required this.selectedVerifications,
    required this.createdOn,
    required this.paymentFrom,
    required this.livelinkType,
    this.paidBy,
    required this.linkExpiredDays,
    required this.statusType,
    this.linkOpenedOn,
    required this.linkSentOn,
    required this.ambiguityFoundIn,
    required this.ambiguityData,
  });

  factory LiveLinkUser.fromJson(Map<String, dynamic> json) {
    // ---- paidBy: Convert empty string "" to null ----
    // API sends "paid_by": "" which means "nobody paid"
    // We convert "" → null so in UI we just check: if (paidBy != null)
    final String rawPaidBy = json['paid_by']?.toString() ?? '';

    // ---- linkOpenedOn: Convert "0000-00-00 00:00:00" to null ----
    // API sends this dummy date when link was never opened
    // We convert it → null so in UI we check: if (linkOpenedOn != null)
    final String rawLinkOpened = json['linkOpendedOn']?.toString() ?? '';
    final bool isNeverOpened =
        rawLinkOpened.isEmpty ||
        rawLinkOpened == '0000-00-00 00:00:00' ||
        rawLinkOpened == '0000-00-00';

    return LiveLinkUser(
      endUserId: json['end_user_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      contactNo: json['contactNo']?.toString() ?? '',
      emailId: json['emailId']?.toString() ?? '',
      entityName: json['entityName']?.toString() ?? '',
      selectedVerifications: json['selectedVerifications']?.toString() ?? '',
      createdOn: json['createdOn']?.toString() ?? '',
      paymentFrom: json['paymentFrom']?.toString() ?? '',
      livelinkType: json['livelink_type']?.toString() ?? '',
      paidBy: rawPaidBy.isNotEmpty ? rawPaidBy : null,
      linkExpiredDays: json['linkExpiredDays']?.toString() ?? '',
      statusType: json['statusType']?.toString() ?? '',
      linkOpenedOn: isNeverOpened ? null : rawLinkOpened,
      linkSentOn: json['linkSentOn']?.toString() ?? '',
      ambiguityFoundIn: json['ambiguityFoundIn']?.toString() ?? '',
      ambiguityData: json['ambiguityData'] as List<dynamic>? ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'end_user_id': endUserId,
      'name': name,
      'contactNo': contactNo,
      'emailId': emailId,
      'entityName': entityName,
      'selectedVerifications': selectedVerifications,
      'createdOn': createdOn,
      'paymentFrom': paymentFrom,
      'livelink_type': livelinkType,
      'paid_by': paidBy ?? '',
      'linkExpiredDays': linkExpiredDays,
      'statusType': statusType,
      'linkOpendedOn': linkOpenedOn ?? '0000-00-00 00:00:00',
      'linkSentOn': linkSentOn,
      'ambiguityFoundIn': ambiguityFoundIn,
      'ambiguityData': ambiguityData,
    };
  }

  @override
  List<Object?> get props => [
    endUserId,
    name,
    contactNo,
    emailId,
    entityName,
    selectedVerifications,
    createdOn,
    paymentFrom,
    livelinkType,
    paidBy,
    linkExpiredDays,
    statusType,
    linkOpenedOn,
    linkSentOn,
    ambiguityFoundIn,
    ambiguityData,
  ];
}

// ======================================================================
// HEADER DATA MODEL
// ======================================================================
// From: "header_data": { "total_active_live_user": 1, ... }
// All counts → always show → int + ?? 0

class HeaderData extends Equatable {
  final int totalActiveLiveUser;
  final int totalCompletedEnduser;
  final int totalAmbiguityEndUser;
  final int totalNotCompletedEnduser;

  const HeaderData({
    required this.totalActiveLiveUser,
    required this.totalCompletedEnduser,
    required this.totalAmbiguityEndUser,
    required this.totalNotCompletedEnduser,
  });

  factory HeaderData.fromJson(Map<String, dynamic> json) {
    return HeaderData(
      totalActiveLiveUser: json['total_active_live_user'] ?? 0,
      totalCompletedEnduser: json['total_completed_enduser'] ?? 0,
      totalAmbiguityEndUser: json['total_ambiguity_end_user'] ?? 0,
      totalNotCompletedEnduser: json['total_not_completed_enduser'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
    totalActiveLiveUser,
    totalCompletedEnduser,
    totalAmbiguityEndUser,
    totalNotCompletedEnduser,
  ];
}

// ======================================================================
// PAGINATION DATA MODEL
// ======================================================================
// From: "pagination_data": { "total_records": 1, "current_page": "1", ... }

class PaginationData extends Equatable {
  final int totalRecords;
  final int currentPage;
  final int totalPages;

  const PaginationData({
    required this.totalRecords,
    required this.currentPage,
    required this.totalPages,
  });

  factory PaginationData.fromJson(Map<String, dynamic> json) {
    return PaginationData(
      // Some APIs send numbers as String ("1") instead of int (1)
      // int.tryParse handles both:
      //   int.tryParse("1") → 1
      //   int.tryParse(null) → null → ?? 0
      totalRecords: int.tryParse(json['total_records']?.toString() ?? '') ?? 0,
      currentPage: int.tryParse(json['current_page']?.toString() ?? '') ?? 0,
      totalPages: int.tryParse(json['total_pages']?.toString() ?? '') ?? 0,
    );
  }

  @override
  List<Object?> get props => [totalRecords, currentPage, totalPages];
}

// ======================================================================
// LIVELINK RESPONSE MODEL (The full API response wrapper)
// ======================================================================
// Wraps everything: error_code + header + pagination + user list
//
// This model is ONLY created when error_code == 100 (success)
// For error responses, we throw exceptions instead of creating this model

class LiveLinkResponseModel extends Equatable {
  final String message;
  final String responseCode;
  final HeaderData headerData;
  final PaginationData paginationData;
  final List<LiveLinkUser> users;

  const LiveLinkResponseModel({
    required this.message,
    required this.responseCode,
    required this.headerData,
    required this.paginationData,
    required this.users,
  });

  factory LiveLinkResponseModel.fromJson(Map<String, dynamic> json) {
    // ---- Parse header_data ----
    // Object → could be null → use HeaderData? check
    // But since this model is only created on success, header should exist
    // Still safe to handle null just in case
    final headerData = json['header_data'] != null
        ? HeaderData.fromJson(json['header_data'])
        : const HeaderData(
            totalActiveLiveUser: 0,
            totalCompletedEnduser: 0,
            totalAmbiguityEndUser: 0,
            totalNotCompletedEnduser: 0,
          );

    // ---- Parse pagination_data ----
    final paginationData = json['pagination_data'] != null
        ? PaginationData.fromJson(json['pagination_data'])
        : const PaginationData(totalRecords: 0, currentPage: 0, totalPages: 0);

    // ---- Parse user_data_array ----
    // TRICKY! API sends: "user_data_array": [ [ {user1}, {user2} ] ]
    // It's a List inside a List! (double nested)
    // We need to flatten it to get: [ {user1}, {user2} ]
    List<LiveLinkUser> users = [];
    final rawUserArray = json['user_data_array'] as List<dynamic>?;
    if (rawUserArray != null && rawUserArray.isNotEmpty) {
      // rawUserArray = [ [ {user1}, {user2} ] ]
      // rawUserArray[0] = [ {user1}, {user2} ]
      for (final innerList in rawUserArray) {
        if (innerList is List) {
          for (final userJson in innerList) {
            if (userJson is Map<String, dynamic>) {
              users.add(LiveLinkUser.fromJson(userJson));
            }
          }
        }
      }
    }

    return LiveLinkResponseModel(
      message: json['message']?.toString() ?? '',
      responseCode: json['response_code']?.toString() ?? '',
      headerData: headerData,
      paginationData: paginationData,
      users: users,
    );
  }

  @override
  List<Object?> get props => [
    message,
    responseCode,
    headerData,
    paginationData,
    users,
  ];
}
