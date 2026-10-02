class UserEntity {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? image;


  const UserEntity({
    required this.phone,
    required this.id,
    required this.name,
    required this.email,
    this.image,
  });
}