import 'package:flutter/material.dart';

class TextBorder extends StatelessWidget {
  final String string;
  final double six;
  final Color color;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final Widget child;
  final Function onTap;
  final String hint;

  TextBorder(
      {@override this.string,
      @override this.six,
      @override this.color,
      @override this.hint,
      @override this.onTap,
      @override this.child,
      @override this.textAlign,
      @override this.fontWeight});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(30),
          right: Radius.circular(30),
        ),
        border: Border.all(
          color: Colors.blueAccent,
        ),
      ),
      child: child,
    );
  }
}
//
// class DropDownBtn extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
