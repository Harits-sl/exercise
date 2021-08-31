class Course {
  final int id;
  final String thumbnailKelas;
  final String namaKelas;
  final List bagian;

  Course(
      {required this.id,
      required this.thumbnailKelas,
      required this.namaKelas,
      required this.bagian});

  factory Course.fromJsonAllCourseStarter(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      thumbnailKelas: json['thumbnail_kelas'] ??
          '/storage/assets/thumbnails/kelas_webflow_dasar_thumb.png',
      namaKelas: json['nama_kelas'] ?? '',
      bagian: [],
    );
  }

  factory Course.fromJsonDetailCourseStarter(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      namaKelas: json['nama_kelas'] ?? '',
      bagian: json['bagian'],
      thumbnailKelas: '',
    );
  }
}
