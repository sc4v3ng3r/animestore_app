class AnimeCacheData {

  final String id;
  final String imageUrl;

  AnimeCacheData(this.id, this.imageUrl);

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'imageUrl': this.imageUrl,
  };

  AnimeCacheData.fromJson(Map<String,dynamic> json) :
        id = json['id'],
        imageUrl = json['imageUrl'];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AnimeCacheData &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

}