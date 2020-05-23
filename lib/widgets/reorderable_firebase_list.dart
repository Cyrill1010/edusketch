import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

typedef ReorderableWidgetBuilder = Widget Function(
    BuildContext context, int index, DocumentSnapshot doc);

class ReorderableFirebaseList extends StatefulWidget {
  const ReorderableFirebaseList({
    Key key,
    @required this.header,
    @required this.collection,
    @required this.indexKey,
    @required this.itemBuilder,
    this.descending = false,
  }) : super(key: key);

  final Widget header;
  final CollectionReference collection;
  final String indexKey;
  final bool descending;
  final ReorderableWidgetBuilder itemBuilder;

  @override
  _ReorderableFirebaseListState createState() => _ReorderableFirebaseListState();
}

class _ReorderableFirebaseListState extends State<ReorderableFirebaseList> {
  List<DocumentSnapshot> _docs;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.collection.orderBy(widget.indexKey, descending: widget.descending).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          _docs = snapshot.data.documents;
          return ReorderableListView(
            header: widget.header,
            onReorder: _onReorder,
            scrollDirection: Axis.vertical,
            children: List.generate(_docs.length, (int index) {
              return widget.itemBuilder(context, index, _docs[index]);
            }),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    _docs.insert(newIndex, _docs.removeAt(oldIndex));
    final batch = Firestore.instance.batch();
    for (int pos = 0; pos < _docs.length; pos++) {
      batch.updateData(_docs[pos].reference, {widget.indexKey: pos});
    }
    batch.commit();
  }
}
