class CourseVideoDetailModel {
  final int id;
  final String namaMateri;
  final String videoMateri;

  CourseVideoDetailModel({
    required this.id,
    required this.namaMateri,
    required this.videoMateri,
  });

  factory CourseVideoDetailModel.fromJson(Map<String, dynamic> json) {
    return CourseVideoDetailModel(
      id: json['id'],
      namaMateri: json['nama_materi'],
      videoMateri: json['video_materi'],
    );
  }
}
