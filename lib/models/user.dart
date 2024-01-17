class UserHeader {
  static const String id = 'id';
  static const String name = 'name';
  static const String phone = 'phone';
  static const String gender = 'gender';
  static const String description = 'description';
  static const String isBeginer = 'isBeginer';

  static List<String> getHeader() => [
        id,
        name,
        phone,
        gender,
        description,
        isBeginer,
      ];
}

class UserFields {
  final int? id;
  final String name;
  final String phone;
  final String gender;
  final String description;
  final bool isBeginer;

  UserFields({
    this.id,
    required this.name,
    required this.phone,
    required this.gender,
    required this.description,
    required this.isBeginer,
  });

  Map<String, dynamic> toJson() => {
        UserHeader.id: id,
        UserHeader.name: name,
        UserHeader.phone: phone,
        UserHeader.gender: gender,
        UserHeader.description: description,
        UserHeader.isBeginer: isBeginer,
      };
}
