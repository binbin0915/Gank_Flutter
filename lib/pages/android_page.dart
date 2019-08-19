import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/entity/android.dart';
import 'package:flutter_shop/service/service_methon.dart';
import 'package:flutter_shop/widgets/android_item_widget.dart';

class AndroidPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AndroidState();
}

class _AndroidState extends State with AutomaticKeepAliveClientMixin {
  ScrollController _controller;
  List<AndroidResults> androidData = List();
  int index = 1;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      var position = _controller.position;
      if (position.maxScrollExtent - position.pixels < 50) {
        _refresh();
      }
    });
    _refresh();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.instance = ScreenUtil(
      width: 1080,
      height: 1920,
    )..init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Android'),
        centerTitle: true,
      ),
      body: Container(
        width: ScreenUtil().setWidth(1080),
        height: ScreenUtil().setHeight(1920),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return AndroidItemWidget(results: androidData[index]);
          },
          itemCount: androidData.length,
          controller: _controller,
        ),
      ),
    );
  }

  void _refresh() {
    getAndroidData(index++).then((data) {
      setState(() {
        Android android = Android.fromJsonMap(data);
        androidData.addAll(android.results);
      });
    });
  }
}