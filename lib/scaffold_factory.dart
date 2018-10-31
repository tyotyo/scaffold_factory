import 'package:flutter/material.dart';

class ScaffoldFactory {
  GlobalKey<ScaffoldState> scaffoldKey;
  ScaffoldFactoryButtonsBehavior buttonsBehavior;
  bool primary = true;

  /// Color, Palette and Theme
  MaterialPalette colorPalette;
  List<Color> gradientBackgroundColors;
  BackgroundType backgroundType = BackgroundType.normal;
  TextTheme textTheme;

  /// Appbar
  ScaffoldVisibility appBarVisibility;
  AppBar appBar;

  factory ScaffoldFactory(GlobalKey<ScaffoldState> scaffoldKey,
          MaterialPalette materialPalette) =>
      ScaffoldFactory._internal(scaffoldKey, materialPalette);

  ScaffoldFactory._internal(this.scaffoldKey, this.colorPalette);

  void init({
    BackgroundType backgroundType,
    ScaffoldVisibility appBarVisibility = ScaffoldVisibility.invisible,
    Widget appBar,
  }) {
    this.backgroundType = backgroundType;
    this.appBarVisibility = appBarVisibility;
    this.appBar = appBar;
  }

  Widget build(BuildContext context, Widget bodyWidget) {
    this.textTheme = Theme.of(context).textTheme;
//    checkNotificationStatus();
    return Scaffold(
      key: scaffoldKey,
      primary: primary,
      appBar: isVisible(appBarVisibility) ? this.appBar : null,
//      floatingActionButtonLocation: floatingActionButtonLocation,
//      bottomNavigationBar: _buildBottomNavigationBar(),
//      floatingActionButton: _buildFloatingActionButton(),
      body: Container(
        decoration: BoxDecoration(
          color: backgroundType == BackgroundType.solidColor
              ? colorPalette.primaryColor
              : null,
          gradient: backgroundType == BackgroundType.gradient
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientBackgroundColors,
                )
              : null,
        ),
//        child: isVisible(nestedAppbarVisibility)
//            ? _buildNestedScrollView(bodyWidget)
//            : bodyWidget ?? Center(),
        child: bodyWidget,
      ),
    );
  }

  /// Simple implementation of AppBar which user can use it with
  /// easy configuration
  AppBar buildAppBar({
    @required ScaffoldVisibility titleVisibility,
    @required ScaffoldVisibility leadingVisibility,
    Widget titleWidget,
    Widget leadingWidget,
    Color backgroundColor,
  }) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading:
          ScaffoldFactory.isVisible(leadingVisibility) ? leadingWidget : null,
      title: ScaffoldFactory.isVisible(titleVisibility) ? titleWidget : null,

//      flexibleSpace: !isVisible(appBarTitleVisibility)
//          ? Column(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: [
//                isVisible(appBarTabBarVisibility)
//                    ? TabBar(
//                        isScrollable: this.isTabScrollable,
//                        tabs: this.tabList,
//                        controller: this.tabController,
//                        indicatorWeight: 4.0,
//                      )
//                    : null,
//              ],
//            )
//          : null,
//      bottom: isVisible(appBarTitleVisibility)
//          ? isVisible(appBarTabBarVisibility)
//              ? TabBar(
//                  isScrollable: this.isTabScrollable,
//                  tabs: this.tabList,
//                  controller: this.tabController,
//                  indicatorWeight: 4.0,
//                )
//              : null
//          : null,
    );
  }

//  NestedScrollView _buildNestedScrollView(Widget bodyWidget) {
//    return NestedScrollView(
////                controller: scrollController ??
////                    ScrollController(initialScrollOffset: 0.0),
//      headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
//        return <Widget>[
//          CustomSliverAppBar(
//            showTabBar: isVisible(appBarTabBarVisibility),
//            tabList: this.tabList,
//            tabColor: this.colorPalette.primaryColor,
//            isScrollable: this.isTabScrollable,
//            showTitle: isVisible(appBarTitleVisibility),
//            tabController: tabController,
//            title: this.appBarTitle,
//            backButtonColor: backButtonColor,
//            floating: appBarFloating,
//          )
//        ];
//      },
//      body: bodyWidget ?? Center(),
//    );
//  }

//  Widget _buildBottomNavigationBar() {
//    return isVisible(bottomNavigationBarVisibility)
//        ? CustomBottomAppBar(
//      textTheme: textTheme,
//      color: this.colorPalette.primaryColor,
//      fabLocation: FloatingActionButtonLocation.centerDocked,
//      showNotch: showNotch,
//      splashColor: this.colorPalette.accentColor,
//      navigationOption: navigationOption,
//      scaffoldFactory: this,
//      activeNotification: notificationActive,
//    )
//        : null;
//  }

//  Widget _buildFloatingActionButton() {
//    return isVisible(floatingActionButtonVisibility)
//        ? !enableMultiActionFab
//        ? FloatingActionButton(
//      heroTag: fabHeroTag,
//      onPressed: () => this.floatingActionBarBehavior.onFABPressed(),
//      tooltip: this.fabTooltip,
//      child: fabBody ??
//          Image.asset(
//            'asset/image/logo.png',
//            width: 25.0,
//            fit: BoxFit.fill,
//          ),
//      backgroundColor: this.colorPalette.accentColor,
//    )
//        : AnimatedFabDialer(
//        parentButtonBackground: this.colorPalette.accentColor,
//        parentHeroTag: fabHeroTag,
//        orientation: AnimatedFabOrientation.vertical,
//        parentButton: Icon(
//          childButtons.length > 2 ? Icons.attach_file : Icons.menu,
//          color: Colors.white,
//          size: 36.0,
//        ),
//        hasBackground: true,
//        backgroundColor: Colors.black.withOpacity(0.6),
////                  onMainButtonPressed: () =>
////                      this.floatingActionBarBehavior.onFABPressed(),
//        childButtons: childButtons)
//        : null;
//  }

//  changeFrameColor() {
//    if (Platform.isAndroid) {
//      _changeStatusColor(this.colorPalette.primaryColor);
//      _changeNavigationColor(this.colorPalette.secondaryColor);
//    }
//  }
//
//  _changeStatusColor(Color color) async {
//    try {
//      await FlutterStatusbarcolor.setStatusBarColor(color);
//    } on PlatformException catch (e) {
//      print(e);
//    }
//  }
//
//  _changeNavigationColor(Color color) async {
//    try {
//      await FlutterStatusbarcolor.setNavigationBarColor(color);
//    } on PlatformException catch (e) {
//      print(e);
//    }
//  }

  static bool isVisible(ScaffoldVisibility visibility) {
    if (visibility == ScaffoldVisibility.visible)
      return true;
    else if (visibility == ScaffoldVisibility.invisible)
      return false;
    else
      return null;
  }

  void dispose() {
//    _notificationSubscription.cancel();
  }

//  void checkNotificationStatus() {
//    SharedPreferences.getInstance().then((SharedPreferences sp) {
//      notificationActive = sp.getBool("new_notification") ?? false;
//
//      if (notificationSeen) {
//        notificationActive = false;
//        notificationSeen = false;
//        sp.setBool("new_notification", notificationActive);
//      }
//    });
//  }
}

abstract class ScaffoldFactoryButtonsBehavior {
  void onBackButtonPressed();

  void onFloatingActionButtonPressed();
}

enum ScaffoldVisibility {
  visible,
  invisible,
}

enum BackgroundType {
  normal,
  solidColor,
  gradient,
}

class MaterialPalette {
  final Color primaryColor;
  final Color darkPrimaryColor;
  final Color lightPrimaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final Color textColor;
  final Color secondaryTextColor;
  final Color iconColor;
  final Color dividerColor;

  MaterialPalette({
    @required this.primaryColor,
    this.secondaryColor,
    @required this.accentColor,
    this.textColor,
    this.darkPrimaryColor,
    this.lightPrimaryColor,
    this.secondaryTextColor,
    this.iconColor,
    this.dividerColor,
  });
}
