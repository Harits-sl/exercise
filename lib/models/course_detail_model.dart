class CourseDetailModel {
  final int id;
  final String levelKelas;
  final String thumbnailKelas;
  final String trailerKelas;
  final String namaKelas;
  final String tentangKelas;
  final String tagline;
  final int joinedAmount;
  final List bagian;
  final List keyPoints;
  final List personas;
  final List authors;
  final Map category;
  final List tools;

  CourseDetailModel({
    required this.id,
    required this.levelKelas,
    required this.thumbnailKelas,
    required this.trailerKelas,
    required this.namaKelas,
    required this.tentangKelas,
    required this.tagline,
    required this.joinedAmount,
    required this.bagian,
    required this.keyPoints,
    required this.personas,
    required this.authors,
    required this.category,
    required this.tools,
  });

  factory CourseDetailModel.fromJson(Map<String, dynamic> json) {
    return CourseDetailModel(
      id: json['id'],
      levelKelas: json['level_kelas'] ?? '',
      thumbnailKelas: json['thumbnail_kelas'] ??
          '/storage/assets/thumbnails/kelas_webflow_dasar_thumb.png',
      trailerKelas: json['trailer_kelas'] ?? '',
      namaKelas: json['nama_kelas'] ?? '',
      tentangKelas: json['tentang_kelas'] ?? '',
      tagline: json['tagline'] ?? '',
      joinedAmount: json['joined_amount'] ?? '',
      bagian: json['bagian'] ?? [],
      keyPoints: json['keypoints'] ?? [],
      personas: json['personas'] ?? [],
      authors: json['authors'] ?? [],
      category: json['category'] ?? {},
      tools: json['tools'] ?? [],
    );
  }
}
