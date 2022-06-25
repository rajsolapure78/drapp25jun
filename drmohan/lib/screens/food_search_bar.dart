import 'package:flutter/material.dart';

class FoodSearchBar extends StatefulWidget {
  const FoodSearchBar({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final Function(String text) onChanged;

  @override
  _FoodSearchBarState createState() => _FoodSearchBarState();
}

class _FoodSearchBarState extends State<FoodSearchBar> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 15, bottom: 20, left: 10, right: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15.0,
              spreadRadius: 4.0,
              offset: const Offset(
                0.0,
                5.0,
              ),
            )
          ],
        ),
        child: Row(children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: _textEditingController,
              onChanged: widget.onChanged,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                suffix: InkWell(onTap: _onTap, child: const Icon(Icons.clear)),
                icon: const Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                  ),
                  child: Icon(
                    Icons.search,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15.0),
                border: InputBorder.none,
              ),
              onEditingComplete: () {},
            ),
          ),
        ]),
      ),
    );
  }

  void _onTap() {
    _textEditingController.clear();
    widget.onChanged.call("");
  }
}
