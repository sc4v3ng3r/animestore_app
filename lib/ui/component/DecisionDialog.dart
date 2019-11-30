

//class DecisionDialog extends StatelessWidget {
//  final String title;
//  final String message;
//  final VoidCallback onConfirm, onCancel;
//
//  const DecisionDialog({Key key,
//    @required this.title,
//    @required this.message,
//    this.onConfirm,
//    this.onCancel}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return AlertDialog(
//      title: Text(title),
//      content: Text(message),
//      actions: <Widget>[
//
//        FlatButton(
//            onPressed: onCancel,
//            child: Text('Cancelar')
//        ),
//
//        FlatButton(
//            onPressed: onConfirm,
//            child: Text('Confirmar')
//        ),
//      ],
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(8.0),
//      ),
//    );
//  }
//}
