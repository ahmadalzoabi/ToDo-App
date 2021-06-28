import 'package:flutter/material.dart';

// button
Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 5.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

// form field
Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
  bool readOnly = false,
  bool showCursor = false,
  FocusNode focusNodeField,
  TextInputAction textInputAction = TextInputAction.next,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      showCursor: showCursor,
      readOnly: readOnly,
      focusNode: focusNodeField,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

// one item list
class SingleTaskItem extends StatelessWidget {
  final int id;
  final String title;
  final String time;
  final String date;
  final Function doneFunction;
  final Function archiveFunction;
  final Function deleteFunction;
  final bool isShowArchive;
  final bool isShowDone;
  const SingleTaskItem({
    Key key,
    @required this.id,
    @required this.title,
    @required this.date,
    @required this.time,
    this.isShowDone = true,
    this.isShowArchive = true,
    this.doneFunction,
    this.archiveFunction,
    this.deleteFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        width: 40,
        color: Colors.green,
        child: Icon(
          Icons.check_circle_outline_rounded,
          color: Colors.white,
          size: 30.0,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 15),
        margin: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 4,
        ),
      ),
      secondaryBackground: Container(
        width: 40,
        color: Theme.of(context).accentColor,
        child: Icon(
          Icons.archive,
          color: Colors.white,
          size: 30.0,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 15),
        margin: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 4,
        ),
      ),
      direction: (isShowArchive == false && isShowDone == true)
          ? DismissDirection.startToEnd
          : (isShowDone == false && isShowArchive == true)
              ? DismissDirection.endToStart
              : DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure !!'),
            content: direction == DismissDirection.endToStart
                ? Text(
                    'Do you want to Archived this Task?',
                  )
                : Text(
                    'Do you finished this Task?',
                  ),
            actions: <Widget>[
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        direction == DismissDirection.endToStart
            ? archiveFunction()
            : doneFunction();
      },
      child: Container(
        padding: EdgeInsets.all(6),
        color: Colors.grey[100],
        child: ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context).accentColor,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    time,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: SizedBox(
                  width: 2.0,
                  height: 38.0,
                  child: Container(
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            date,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          horizontalTitleGap: 8.0,
          trailing: Container(
            width: 60.0,
            child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                  size: 25.0,
                ),
                onPressed: deleteFunction),
          ),
          contentPadding: EdgeInsets.all(0.0),
        ),
      ),
    );
  }
}

// no items yet in UI
class NoTasks extends StatelessWidget {
  const NoTasks({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            size: 60.0,
            color: Colors.black.withOpacity(0.6),
          ),
          SizedBox(height: 10.0),
          Text(
            'No Tasks Yet, Please Add Some',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
