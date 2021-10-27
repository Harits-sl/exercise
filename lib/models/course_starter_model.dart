class CourseStarterModel {
  final int id;
  final String thumbnailKelas;
  final String namaKelas;
  final String authorKelas;
  final String trailerKelas;
  final int joinedAmount;

  CourseStarterModel({
    required this.id,
    required this.thumbnailKelas,
    required this.namaKelas,
    required this.authorKelas,
    required this.trailerKelas,
    required this.joinedAmount,
  });

  factory CourseStarterModel.fromJson(Map<String, dynamic> json) {
    return CourseStarterModel(
      id: json['id'],
      thumbnailKelas: json['thumbnail_kelas'] ??
          '/storage/assets/thumbnails/kelas_webflow_dasar_thumb.png',
      namaKelas: json['nama_kelas'] ?? '',
      authorKelas: json['author_kelas'] ?? '',
      trailerKelas: json['trailer_kelas'] ?? '',
      joinedAmount: json['joined_amount'] ?? '',
    );
  }
}
