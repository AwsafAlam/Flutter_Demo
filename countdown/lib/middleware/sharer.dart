// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:share/share.dart';

import '../domain/index.dart';

class Sharer implements SharerContract {
  void shareScore(String text, int score) {
    const placeholder = '{{score}}';
    Share.share(text.replaceAll(placeholder, score.toString()));
  }

  void rateApp() {
    //LaunchReview.launch();
  }
}
