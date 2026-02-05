import 'package:json_annotation/json_annotation.dart';

part 'register_user_model.g.dart';

@JsonSerializable()
class User {
    @JsonKey(name: "firstName")
    String? firstName;
    @JsonKey(name: "lastName")
    String? lastName;
    @JsonKey(name: "email")
    String? email;
    @JsonKey(name: "gender")
    String? gender;
    @JsonKey(name: "phone")
    String? phone;
    @JsonKey(name: "photo")
    String? photo;
    @JsonKey(name: "role")
    String? role;
    @JsonKey(name: "wishlist")
    List<dynamic>? wishlist;
    @JsonKey(name: "_id")
    String? id;
    @JsonKey(name: "addresses")
    List<dynamic>? addresses;
    @JsonKey(name: "createdAt")
    DateTime? createdAt;

    User({
        this.firstName,
        this.lastName,
        this.email,
        this.gender,
        this.phone,
        this.photo,
        this.role,
        this.wishlist,
        this.id,
        this.addresses,
        this.createdAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

    Map<String, dynamic> toJson() => _$UserToJson(this);
}
