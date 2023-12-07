import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'avatar_model.dart';
export 'avatar_model.dart';

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({Key? key}) : super(key: key);

  @override
  _AvatarWidgetState createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  late AvatarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AvatarModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.00, 1.00),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 0.6,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 1.0,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(25.0, 25.0, 25.0, 25.0),
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFCFCECE),
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                  Container(
                    width: 90.0,
                    height: 7.5,
                    decoration: BoxDecoration(
                      color: Color(0xFFCFCECE),
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
                        child: Icon(
                          Icons.close,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 22.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FFLocalizations.of(context).getText(
                      'jzq9nklj' /* Hand Drawn Collection (15) */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  GridView(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.0,
                    ),
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        width: 20.0,
                        height: 20.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set2-Asset%208.png?alt=media&token=74b603be-0c41-4148-a662-7e0d85138c01',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 40.0,
                        height: 40.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set2-Asset%206.png?alt=media&token=d098d362-1149-4d7f-b8e3-c7b6e557fc12',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 40.0,
                        height: 40.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set2-Asset%205.png?alt=media&token=7e8008cc-7256-42bb-87ff-d2a0786b6e70',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set2-Asset%204.png?alt=media&token=2c3f49a4-f3a0-430d-a72b-d64dca98886f',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set2-Asset%203.png?alt=media&token=851c4a79-7177-4819-bf82-f91dc0c0a870',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set2-Asset%202.png?alt=media&token=2247cf90-def9-42d0-a52c-bd618e35c579',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set2-Asset%2017.png?alt=media&token=df19bf8f-1c0b-4dcf-8da5-2ce8d2df509f',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set2-Asset%2018.png?alt=media&token=8f73507d-9876-4a90-a48e-f2d22926a824',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set2-Asset%2016.png?alt=media&token=f0b2c95f-f964-49f9-8837-4ec4a91b4d3f',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set2-Asset%2013.png?alt=media&token=980938d3-8355-475c-a942-f06f68457af7',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set2-Asset%2014.png?alt=media&token=1268bc3b-d5b7-41a5-a26b-e152da67555f',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set2-Asset%2015.png?alt=media&token=546e0f6e-02a0-4b11-8366-ff77b4e57ea2',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set2-Asset%2012.png?alt=media&token=e8788690-806d-4f5e-bf82-dfbec1225fee',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set2-Asset%2011.png?alt=media&token=665c480c-c288-4faa-832d-6287c7dddfd7',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set2-Asset%2010.png?alt=media&token=50f0a8c8-c430-496f-ab60-eb41f64a2e37',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ].divide(SizedBox(height: 15.0)),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FFLocalizations.of(context).getText(
                      '5yscyqp1' /* Hand Drawn Collection (15) */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  GridView(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.0,
                    ),
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        width: 20.0,
                        height: 20.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%2010.png?alt=media&token=908dd101-9ded-426a-b43f-34eae28ec616',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 40.0,
                        height: 40.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%2011.png?alt=media&token=e4902bbb-935a-4972-9e95-c3577e351c63',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 40.0,
                        height: 40.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%2012.png?alt=media&token=32e648ba-3607-40ef-83b6-c1e8bf7830ed',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%2013.png?alt=media&token=d6b371ff-78fe-41e4-aee4-80f125785021',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set2-Asset%203.png?alt=media&token=851c4a79-7177-4819-bf82-f91dc0c0a870',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%2015.png?alt=media&token=eb3b19d3-3d80-455e-ad25-72950f65366b',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%2016.png?alt=media&token=4c910b06-9710-4926-863e-9f74a9915c49',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%202.png?alt=media&token=a11e794d-b446-4cf1-9551-8fdf0ae41446',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%203.png?alt=media&token=ffc0065a-5e0b-4154-bd7c-5240b6d90ce4',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%204.png?alt=media&token=20e6c707-2bb1-47c8-b964-a43a83cb16db',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%205.png?alt=media&token=544c21a8-3848-4ce8-ba03-488eefd67ab2',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%206.png?alt=media&token=a3176c37-22fa-49f0-a1d4-de59f5d98cf4',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%207.png?alt=media&token=a582fd49-5a13-41ae-ac01-252f8a3a6004',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%209.png?alt=media&token=96483ee2-186e-4ffe-b85b-1a15eb604c63',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%208.png?alt=media&token=81a4bde0-ec03-4070-8517-0a81d76fad2c',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ].divide(SizedBox(height: 15.0)),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FFLocalizations.of(context).getText(
                      'cynag83u' /* Hand Drawn Collection (8) */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  GridView(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.0,
                    ),
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        width: 20.0,
                        height: 20.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%2010.png?alt=media&token=908dd101-9ded-426a-b43f-34eae28ec616',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 40.0,
                        height: 40.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%2011.png?alt=media&token=e4902bbb-935a-4972-9e95-c3577e351c63',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 40.0,
                        height: 40.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%2012.png?alt=media&token=32e648ba-3607-40ef-83b6-c1e8bf7830ed',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%2013.png?alt=media&token=d6b371ff-78fe-41e4-aee4-80f125785021',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set2-Asset%203.png?alt=media&token=851c4a79-7177-4819-bf82-f91dc0c0a870',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%2015.png?alt=media&token=eb3b19d3-3d80-455e-ad25-72950f65366b',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%2016.png?alt=media&token=4c910b06-9710-4926-863e-9f74a9915c49',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%202.png?alt=media&token=a11e794d-b446-4cf1-9551-8fdf0ae41446',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%203.png?alt=media&token=ffc0065a-5e0b-4154-bd7c-5240b6d90ce4',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%204.png?alt=media&token=20e6c707-2bb1-47c8-b964-a43a83cb16db',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%205.png?alt=media&token=544c21a8-3848-4ce8-ba03-488eefd67ab2',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%206.png?alt=media&token=a3176c37-22fa-49f0-a1d4-de59f5d98cf4',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%207.png?alt=media&token=a582fd49-5a13-41ae-ac01-252f8a3a6004',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%209.png?alt=media&token=96483ee2-186e-4ffe-b85b-1a15eb604c63',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/hasanati-85079.appspot.com/o/set1-Asset%208.png?alt=media&token=81a4bde0-ec03-4070-8517-0a81d76fad2c',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ].divide(SizedBox(height: 15.0)),
              ),
            ].divide(SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }
}
