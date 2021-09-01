class Course {
  final int id;
  final String thumbnailKelas;
  final String namaKelas;
  final List bagian;
  final String videoMateri;
  final String namaMateri;

  Course(
      {required this.id,
      required this.thumbnailKelas,
      required this.namaKelas,
      required this.bagian,
      required this.videoMateri,
      required this.namaMateri});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      thumbnailKelas: json['thumbnail_kelas'] ??
          '/storage/assets/thumbnails/kelas_webflow_dasar_thumb.png',
      namaKelas: json['nama_kelas'] ?? '',
      bagian: json['bagian'] ?? [],
      videoMateri: json['video_materi'] ?? '',
      namaMateri: json['nama_materi'] ?? '',
    );
  }
}
