import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReadSubject extends StatelessWidget {
  const ReadSubject({Key key, this.data, this.openContainer}) : super(key: key);
  final data;
  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: Color(int.parse(data['color'])),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListTile(
        onTap: openContainer,
        leading: Icon(
          IconDataSolid(int.parse(data['icon'])),
          size: 40,
        ),
        title: Text(data['name']),
        subtitle: Text(
          'Weight:' + ['weight'].toString() + '%',
        ),
        trailing: Container(
            constraints: BoxConstraints(maxWidth: 100),
            child: RichText(
              text: TextSpan(children: [
                WidgetSpan(
                    child: FaIcon(
                  FontAwesomeIcons.check,
                  size: 20,
                  color: Colors.green[600],
                )),
                TextSpan(
                  text: data['average'].toString(),
                  style: Theme.of(context).textTheme.subtitle1,
                )
              ]),
            )),
      ),
    );
  }
}
