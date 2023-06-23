
// ignore_for_file: constant_identifier_names

enum MimeType { Text, IMAGE, Video }
enum Mode {PUBLIC, USER}
enum PostType {STORY, POST}
enum SourceType {Network, File, Base64}

final modeValue = EnumValues({
  "user": Mode.USER,
  "public": Mode.PUBLIC,
  "network": SourceType.Network,
  "file": SourceType.File,
  "base64": SourceType.Base64,
  "post": PostType.POST,
  "story": PostType.STORY,
  "text": MimeType.Text,
  "image": MimeType.IMAGE,
  "video": MimeType.Video,
});


class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}