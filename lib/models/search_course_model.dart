class SearchCourseModel {
  final int id;
  final String thumbnailKelas;
  final String namaKelas;
  final String authorKelas;
  final String trailerKelas;
  final int joinedAmount;
  final List authors;

  SearchCourseModel({
    required this.id,
    required this.thumbnailKelas,
    required this.namaKelas,
    required this.authorKelas,
    required this.trailerKelas,
    required this.joinedAmount,
    required this.authors,
  });

  factory SearchCourseModel.fromJson(Map<String, dynamic> json) {
    return SearchCourseModel(
      id: json['id'],
      thumbnailKelas: json['thumbnail_kelas'] ??
          '/storage/assets/thumbnails/kelas_webflow_dasar_thumb.png',
      namaKelas: json['nama_kelas'] ?? '',
      authorKelas: json['author_kelas'] ?? '',
      trailerKelas: json['trailer_kelas'] ?? '',
      joinedAmount: json['joined_amount'] ?? 0,
      authors: json['authors'] ?? '',
    );
  }
}
