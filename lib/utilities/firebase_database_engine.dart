

class DataEngine {
//  static Future<bool> login(String username, String password) async {
//    DataSnapshot quickMembersRef =
//        await FirebaseDatabase.instance.reference().child("quick_member/$username").once();
//
//    Map v = quickMembersRef.value;
//
//    if (v == null) return false;
//
//    String primaryKey;
//    String realPassword;
//
//    v.forEach((key, value) {
//      print("$password != $realPassword => $key");
//      if (key == "PK") {
//        primaryKey = value;
//      } else if (key == "password") {
//        realPassword = value;
//      }
//    });
//
//    if (password != realPassword) return false;
//
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//
//    prefs.setString(kUserId, primaryKey);
//
//    return true;
//  }
//
//  static Future<bool> registerMember(MemberModel member) async {
//    DatabaseReference membersRef = FirebaseDatabase.instance.reference().child("member").push();
//
//    await membersRef.set(member.toMap());
//
//    DatabaseReference memberInfoRef =
//        FirebaseDatabase.instance.reference().child("member_info/${membersRef.key}");
//
//    List<Map<String, dynamic>> memberInfoMap = [];
//
//    if (member.memberInfo != null)
//      for (MemberInfoModel info in member.memberInfo) {
//        memberInfoMap.add(info.toMap());
//      }
//
//    await memberInfoRef.set(memberInfoMap);
//
////    List<Map<String, dynamic>> memberNotesMap = [];
////
////    if (this.memberNotes != null)
////      for (MemberPersonalNoteModel note in this.memberNotes) {
////        memberNotesMap.add(note.toMap());
////      }
//
//    DatabaseReference quickMembersRef =
//        FirebaseDatabase.instance.reference().child("quick_member/${member.username}");
//
//    await quickMembersRef.set(<String, dynamic>{
//      "PK": membersRef.key,
//      "password": member.password,
//    });
//
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//
//    prefs.setString(kUserId, membersRef.key);
//
//    return true;
//  }
//
//  static Future<List<DivisionModel>> getDivision(BuildContext context) async {
//    DataSnapshot quickMembersRef =
//        await FirebaseDatabase.instance.reference().child("division").orderByKey().once();
//
//    Map v = quickMembersRef.value;
//
//    if (v == null) return [];
//
//    List<DivisionModel> result = [];
//
//    v.keys.toList()
//      ..sort()
//      ..forEach((key) {
//        result.add(DivisionModel(id: key, name: v[key]));
//      });
//
//    return result;
//  }
//
//  static Future<bool> removeDivision(BuildContext context, String key) async {
//    await FirebaseDatabase.instance.reference().child("division/$key").remove();
//
//    return true;
//  }
//
//  static Future<bool> addDivision(BuildContext context, String division) async {
//    DatabaseReference divisionRef = FirebaseDatabase.instance.reference().child("division").push();
//
//    await divisionRef.set(division);
//
//    return true;
//  }
//
//  static Future<bool> editDivision(BuildContext context, DivisionModel division) async {
//    DatabaseReference divisionRef =
//        FirebaseDatabase.instance.reference().child("division/${division.id}");
//
//    await divisionRef.set(division.name);
//
//    return true;
//  }
//
//  static Future<List<DivisionModel>> getSubDivision(
//      BuildContext context, List<DivisionModel> divisions) async {
//    DataSnapshot quickMembersRef =
//        await FirebaseDatabase.instance.reference().child("sub_division").orderByKey().once();
//
//    Map v = quickMembersRef.value;
//
//    if (v == null) return divisions;
//
//    v.forEach((key, value) {
//      String divisionId = value["division_id"];
//      SubDivisionModel subDivision = SubDivisionModel(id: key, name: value["name"]);
//
//      DivisionModel division =
//          divisions.firstWhere((division) => division.id == divisionId, orElse: () => null);
//
//      if (division != null) {
//        division.subDivisions.add(subDivision);
//      }
//    });
//
//    return divisions;
//  }
//
//  static Future<bool> editSubDivision(
//      BuildContext context, SubDivisionModel subDivision, String divisionId) async {
//    DatabaseReference subDivisionRef =
//        FirebaseDatabase.instance.reference().child("sub_division/${subDivision.id}");
//
//    Map subDivisionMap = subDivision.toMap();
//
//    subDivisionMap.putIfAbsent("division_id", () => divisionId);
//
//    await subDivisionRef.set(subDivisionMap);
//
//    return true;
//  }
//
//  static Future<bool> removeSubDivision(BuildContext context, String key) async {
//    await FirebaseDatabase.instance.reference().child("sub_division/$key").remove();
//
//    return true;
//  }
//
//  static Future<bool> addSubDivision(
//      BuildContext context, String divisionId, String subDivision) async {
//    DatabaseReference subDivisionRef =
//        FirebaseDatabase.instance.reference().child("sub_division").push();
//
//    Map subDivisionMap = {
//      "division_id": divisionId,
//      "name": subDivision,
//    };
//
//    await subDivisionRef.set(subDivisionMap);
//
//    return true;
//  }
//
//  static Future<List<DivisionModel>> getReviewCriterion(
//      BuildContext context, List<DivisionModel> divisions) async {
//    DataSnapshot quickMembersRef =
//        await FirebaseDatabase.instance.reference().child("review_criterion").orderByKey().once();
//
//    Map v = quickMembersRef.value;
//
//    if (v == null) return divisions;
//
//    v.forEach((key, value) {
//      String divisionId = value["division_id"];
//      String subDivisionId = value["sub_division_id"];
//      ReviewCriteriaModel reviewCriteria = ReviewCriteriaModel(id: key, name: value["name"]);
//
//      DivisionModel division =
//          divisions.firstWhere((division) => division.id == divisionId, orElse: () => null);
//
//      if (division != null) {
//        SubDivisionModel subDivision = division.subDivisions
//            .firstWhere((subDivision) => subDivision.id == subDivisionId, orElse: () => null);
//
//        if (subDivision != null) {
//          subDivision.criteria.add(reviewCriteria);
//        }
//      }
//    });
//
//    return divisions;
//  }
//
//  static Future<List<VenueModel>> getVenue(BuildContext context) async {
//    DataSnapshot quickMembersRef =
//        await FirebaseDatabase.instance.reference().child("venue").orderByKey().once();
//
//    Map v = quickMembersRef.value;
//
//    if (v == null) return [];
//
//    List<VenueModel> result = [];
//
//    v.keys.toList()
//      ..sort()
//      ..forEach((key) {
//        result.add(VenueModel(id: key, name: v[key]));
//      });
//
//    return result;
//  }
//
//  static Future<bool> removeVenue(BuildContext context, String key) async {
//    await FirebaseDatabase.instance.reference().child("venue/$key").remove();
//
//    return true;
//  }
//
//  static Future<bool> addVenue(BuildContext context, String venue) async {
//    DatabaseReference venueRef = FirebaseDatabase.instance.reference().child("venue").push();
//
//    await venueRef.set(venue);
//
//    return true;
//  }
//
//  static Future<bool> editVenue(BuildContext context, VenueModel venue) async {
//    DatabaseReference venueRef = FirebaseDatabase.instance.reference().child("venue/${venue.id}");
//
//    await venueRef.set(venue.name);
//
//    return true;
//  }
//
//  static Future<List<VenueModel>> getRoom(BuildContext context, List<VenueModel> venues) async {
//    DataSnapshot quickMembersRef =
//        await FirebaseDatabase.instance.reference().child("room").orderByKey().once();
//
//    Map v = quickMembersRef.value;
//
//    if (v == null) return venues;
//
//    v.forEach((key, value) {
//      String venueId = value["venue_id"];
//      RoomModel room = RoomModel(id: key, name: value["name"]);
//
//      VenueModel venue = venues.firstWhere((venue) => venue.id == venueId, orElse: () => null);
//
//      if (venue != null) {
//        venue.rooms.add(room);
//      }
//    });
//
//    return venues;
//  }
//
//  static Future<bool> editRoom(BuildContext context, RoomModel room, String venueId) async {
//    DatabaseReference roomRef = FirebaseDatabase.instance.reference().child("room/${room.id}");
//
//    Map roomMap = room.toMap();
//
//    roomMap.putIfAbsent("venue_id", () => venueId);
//
//    await roomRef.set(roomMap);
//
//    return true;
//  }
//
//  static Future<bool> removeRoom(BuildContext context, String key) async {
//    await FirebaseDatabase.instance.reference().child("room/$key").remove();
//
//    return true;
//  }
//
//  static Future<bool> addRoom(BuildContext context, String venueId, String room) async {
//    DatabaseReference roomRef = FirebaseDatabase.instance.reference().child("room").push();
//
//    Map roomMap = {
//      "venue_id": venueId,
//      "name": room,
//    };
//
//    await roomRef.set(roomMap);
//
//    return true;
//  }
//
//  static Future<List<ServiceHourModel>> getServiceHour(BuildContext context) async {
//    DataSnapshot serviceHourRef =
//        await FirebaseDatabase.instance.reference().child("service_hour").orderByKey().once();
//
//    Map v = serviceHourRef.value;
//
//    if (v == null) return [];
//
//    List<ServiceHourModel> result = [];
//
//    v.keys.toList()
//      ..sort()
//      ..forEach((key) {
//        result.add(ServiceHourModel.fromJson(key, v[key]));
//      });
//
//    return result;
//  }
//
//  static Future<bool> removeServiceHour(BuildContext context, String key) async {
//    await FirebaseDatabase.instance.reference().child("service_hour/$key").remove();
//
//    return true;
//  }
//
//  static Future<bool> addServiceHour(BuildContext context, ServiceHourModel serviceHour) async {
//    DatabaseReference divisionRef =
//        FirebaseDatabase.instance.reference().child("service_hour").push();
//
//    await divisionRef.set(serviceHour.toMap());
//
//    return true;
//  }
//
//  static Future<bool> editServiceHour(BuildContext context, ServiceHourModel serviceHour) async {
//    DatabaseReference divisionRef =
//        FirebaseDatabase.instance.reference().child("service_hour/${serviceHour.id}");
//
//    await divisionRef.set(serviceHour.toMap());
//
//    return true;
//  }
//
//  static Future<List<MemberModel>> getMember(BuildContext context) async {
//    DataSnapshot memberRef =
//        await FirebaseDatabase.instance.reference().child("member").orderByKey().once();
//
//    Map v = memberRef.value;
//
//    if (v == null) return [];
//
//    List<MemberModel> result = [];
//
//    v.keys.toList()
//      ..sort()
//      ..forEach((key) {
//        result.add(MemberModel.fromJson(key, v[key]));
//      });
//
//    return result;
//  }
//
//  static Future<List<MemberModel>> getMemberInfo(
//      BuildContext context, List<MemberModel> members) async {
//    DataSnapshot memberInfoRef =
//        await FirebaseDatabase.instance.reference().child("member_info").orderByKey().once();
//
//    Map v = memberInfoRef.value;
//
//    if (v == null) return members;
//
//    v.forEach((key, value) async {
//      MemberModel member = members.firstWhere((member) {
//        print("key => |$key| vs |${member.id}|");
//        return member.id == key;
//      }, orElse: () => null);
//      print("member => $member");
//      print("key => $key");
//      if (member != null) {
//        int revision = 0;
//
//        for (var info in value) {
//          String division = "Nihil";
//          if (info['division_id'] != null) {
//            DataSnapshot divisionNameRef =
//            await FirebaseDatabase.instance.reference()
//                .child("division/${info['division_id']}")
//                .orderByKey()
//                .once();
//
//            division = divisionNameRef.value ?? "Nihil";
//          }
//          member.memberInfo.add(MemberInfoModel.fromJson(revision, info, division));
//
//          revision++;
//        }
//      }
//    });
//
//    return members;
//  }
}
