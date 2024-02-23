import 'dart:convert';

class Post {
    String id;
    String titulo;
    String descripcion;
    DateTime timeStamp;
    String? img;

    Post({
        required this.id,
        required this.titulo,
        required this.descripcion,
        required this.timeStamp,
        this.img,
    });

    factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Post.fromMap(Map<String, dynamic> json) => Post(
        id: json["_id"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        timeStamp: DateTime.parse(json["time_stamp"]),
        img: json["img"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "titulo": titulo,
        "descripcion": descripcion,
        "time_stamp": timeStamp.toIso8601String(),
        "img": img,
    };
}
