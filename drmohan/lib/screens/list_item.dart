import 'package:flutter/cupertino.dart';

abstract class ListItem {
  Widget buildTitle(BuildContext context);

  Widget buildSubtitle(BuildContext context);

  Widget buildTrailing(BuildContext context);
}
