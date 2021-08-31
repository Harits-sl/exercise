class Course {
  final int? id;
  final String? thumbnailKelas;
  final String? namaKelas;

  Course({this.id, this.thumbnailKelas, this.namaKelas});

  factory Course.fromJsonAllCourseStarter(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      thumbnailKelas: json['thumbnail_kelas'] ??
          '/storage/assets/thumbnails/kelas_webflow_dasar_thumb.png',
      namaKelas: json['nama_kelas'] ?? '',
    );
  }
}
