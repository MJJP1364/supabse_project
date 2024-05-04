// ignore_for_file: public_member_api_docs, sort_constructors_first
class CrudModel {
  final int id;
  final String title;
  final String description;
  final String user_id;
  final String? imgUrl;
  final String? fileName;
  CrudModel( {
    required this.id,
    required this.title,
    required this.description,
    required this.user_id,
    this.fileName,
    this.imgUrl,
  });
}
