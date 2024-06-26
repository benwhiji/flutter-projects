import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/models/simple_objects/bible.dart';
import 'package:simple_bible/models/simple_objects/bibleinfo.dart';
import 'package:simple_bible/services/bible.service.dart';

import 'test_helpers.dart';

Future main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  GetIt di = await TestHelpers().createContainer();
  BibleService bibleService = getIt();

  group('Verse', () {
    test('loads bible info successfully', () async {
      BibleInfo info = await bibleService.loadInfo();
      expect(info.versions.isNotEmpty, true);
      expect(info.books.isNotEmpty, true);
      expect(info.books[0].bookNumber == 1, true);
    });
    test('loads simple kjv successfully', () async {
      Bible bible = await bibleService.loadKJV();
      expect(bible.version == "kjv", true);
      expect(bible.books.isNotEmpty, true);
      expect(bible.books[0].bookNumber == 1, true);
      expect(bible.books[0].chapters.isNotEmpty, true);
      expect(bible.books[0].chapters[0].chapterNumber == 1, true);
      expect(bible.books[0].chapters[0].verses.isNotEmpty, true);
      expect(bible.books[0].chapters[0].verses[0].verseNumber == 1, true);
    });
  });
}
