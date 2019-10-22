import 'package:flutter/material.dart';

typedef OnTap = void Function();

class SearchTextField extends StatefulWidget {

  final OnTap onClear;
  final ValueChanged<String> onConfirm;
  final String initialText;
  final double width, height;

  const SearchTextField({Key key,
    this.onClear,
    this.initialText,
    this.onConfirm,
    @required this.width,
    @required this.height}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchTextFieldState();

}

class _SearchTextFieldState extends State<SearchTextField> {

  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialText ?? '');
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      width: widget.width,
      height: widget.height,
      child: TextField(
        autofocus: false,
        controller: controller,
        textInputAction: TextInputAction.done,
        onSubmitted: (str){
          if (widget.onConfirm != null)
            widget.onConfirm(controller.text);
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: (){
                setState(() {
                  controller.text = '';
                });
                if (widget.onClear != null)
                  widget.onClear();
              },
            ),
            hintText: 'Anime, Estudio, Genero...',
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0)
        ),
      ),
    );
  }
}

