import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simple_bible/models/simple_objects/bible_info_book.dart';
import 'package:simple_bible/models/simple_objects/bible_info_version.dart';

part 'bibleinfo.g.dart';

@JsonSerializable()
class BibleInfo extends Equatable{
  List<BibleInfoVersion> versions;
  List<BibleInfoBook> books;

  BibleInfo(this.versions, this.books);
  BibleInfo.empty() : this(List.empty(), List.empty());

  BibleInfo.fromMap(Map<String, dynamic> json)
      : versions = (json["versions"] as List<dynamic>)
            .map((v) => BibleInfoVersion.fromMap(v))
            .toList(),
        books = (json["books"] as List<dynamic>)
            .map((v) => BibleInfoBook.fromJson(v))
            .toList();

  Map<String, dynamic> toMap() {
    return {
      'versions': versions.map((v) => v.toMap()),
      'books': books.map((b) => b.toMap()),
    };
  }

  @override
  List<Object?> get props => [versions, books];

  factory BibleInfo.fromJson(Map<String, dynamic> json) => _$BibleInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BibleInfoToJson(this);
}