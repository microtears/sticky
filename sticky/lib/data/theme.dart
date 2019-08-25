import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shine/shine.dart';
import 'package:zefyr/zefyr.dart';

class ThemeController extends ValueNotifier<ThemeData> {
  ThemeController({ThemeData theme})
      : super(theme == null ? stickyLight : theme);

  static final stickyLight = StickyThemeData(
    brightness: Brightness.light,
    // primarySwatch: Colors.blue,
    accentColor: hexColor("#4e53f7"),

    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarColor: Colors.transparent,
    buttonTheme: ButtonThemeData(
      buttonColor: hexColor("#4e53f7"),
      height: 48,
      textTheme: ButtonTextTheme.primary,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      brightness: Brightness.light,
      color: Colors.transparent,
      textTheme: TextTheme(
        title: TextStyle(
          color: hexColor("#535D7E"),
          fontSize: 21,
        ),
      ),
      iconTheme: ThemeData.light().iconTheme,
    ),
    textTheme: ThemeData.light()
        .textTheme
        .apply(
          bodyColor: hexColor("#535D7E"),
          displayColor: hexColor("#535D7E"),
        )
        .merge(
          TextTheme(
            subhead: TextStyle(color: hexColor("#A4A4BD")),
            display1: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
            button: TextStyle(color: Colors.white),
          ),
        ),
    zefyrThemeData: ZefyrThemeData(),
  );

  static final stickyDark = StickyThemeData(
    // backgroundImage: Uri.parse(kTestBackground),
    brightness: Brightness.dark,
    accentColor: Colors.blue,
    primarySwatch: Colors.blue,
    primaryColorDark: Colors.blue,
    backgroundColor: Colors.black,
    toggleableActiveColor: Colors.blue,
    scaffoldBackgroundColor: Colors.transparent,
    bottomNavigationBarColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      color: Colors.transparent,
      iconTheme: ThemeData.dark().iconTheme,
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
          fontSize: 21,
        ),
      ),
    ),
    zefyrThemeData: ZefyrThemeData(
        paragraphTheme: StyleTheme(
          textStyle: DefaultTextStyle.fallback().style.copyWith(
                fontSize: 16.0,
                height: 1.25,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
        ),
        headingTheme: HeadingTheme(
          level1: StyleTheme(
            textStyle: TextStyle(
              fontSize: 30.0,
              color: Colors.white,
              height: 1.25,
              fontWeight: FontWeight.w600,
            ),
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
          ),
          level2: StyleTheme(
            textStyle: TextStyle(
              fontSize: 24.0,
              color: Colors.white,
              height: 1.25,
              fontWeight: FontWeight.w600,
            ),
            padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
          ),
          level3: StyleTheme(
            textStyle: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              height: 1.25,
              fontWeight: FontWeight.w600,
            ),
            padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
          ),
        ),
        blockTheme: BlockTheme(
          bulletList: StyleTheme(padding: const EdgeInsets.only(bottom: 8.0)),
          numberList: StyleTheme(padding: const EdgeInsets.only(bottom: 8.0)),
          quote: StyleTheme(
            textStyle: TextStyle(color: Colors.white),
            padding: const EdgeInsets.only(bottom: 8.0),
          ),
          code: StyleTheme(
            textStyle: TextStyle(
              color: Colors.blueGrey.shade800,
              fontFamily: Platform.isIOS ? 'Menlo' : 'Roboto Mono',
              fontSize: 14.0,
              height: 1.25,
            ),
            padding: const EdgeInsets.only(bottom: 8.0),
          ),
        )),
  );

  ThemeData get theme => value;

  StickyThemeData get stickyTheme => value is StickyThemeData ? value : null;

  // TODO(microtears) debug help method, please remove before release.
  void refresh() {
    notifyListeners();
  }

  static ThemeController of(BuildContext context) {
    return Provider.of<ThemeController>(context, listen: false);
  }
}

class StickyTheme extends StatelessWidget {
  final Widget child;

  const StickyTheme({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context, controller, child) =>
          AnnotatedRegion<SystemUiOverlayStyle>(
        value: (controller.theme.brightness == Brightness.light
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light)
            .copyWith(
                statusBarColor:
                    controller.stickyTheme.backgroundColor.withOpacity(0.0)),
        child: Theme(
          data: controller.theme,
          child: ZefyrTheme(
            data: controller.stickyTheme.zefyrThemeData,
            child: child,
          ),
        ),
      ),
    );
  }

  static StickyThemeData of(BuildContext context,
      {bool shadowThemeOnly = false}) {
    final theme = Theme.of(context, shadowThemeOnly: shadowThemeOnly);
    return theme is StickyThemeData ? theme : null;
  }
}

class StickyThemeData extends ThemeData {
  /// It can be Http URI or file URI or `null`.
  final Uri backgroundImage;

  /// Background gradient color list,
  /// default value is pure background color.
  final List<Color> backgroundColors;

  /// ZefyrEditor theme data.
  final ZefyrThemeData zefyrThemeData;

  final Color bottomNavigationBarColor;

  factory StickyThemeData({
    Uri backgroundImage,
    List<Color> backgroundColors,
    ZefyrThemeData zefyrThemeData,
    Color bottomNavigationBarColor,
    Brightness brightness,
    MaterialColor primarySwatch,
    Color primaryColor,
    Brightness primaryColorBrightness,
    Color primaryColorLight,
    Color primaryColorDark,
    Color accentColor,
    Brightness accentColorBrightness,
    Color canvasColor,
    Color scaffoldBackgroundColor,
    Color bottomAppBarColor,
    Color cardColor,
    Color dividerColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    InteractiveInkFeatureFactory splashFactory,
    Color selectedRowColor,
    Color unselectedWidgetColor,
    Color disabledColor,
    Color buttonColor,
    ButtonThemeData buttonTheme,
    Color secondaryHeaderColor,
    Color textSelectionColor,
    Color cursorColor,
    Color textSelectionHandleColor,
    Color backgroundColor,
    Color dialogBackgroundColor,
    Color indicatorColor,
    Color hintColor,
    Color errorColor,
    Color toggleableActiveColor,
    String fontFamily,
    TextTheme textTheme,
    TextTheme primaryTextTheme,
    TextTheme accentTextTheme,
    InputDecorationTheme inputDecorationTheme,
    IconThemeData iconTheme,
    IconThemeData primaryIconTheme,
    IconThemeData accentIconTheme,
    SliderThemeData sliderTheme,
    TabBarTheme tabBarTheme,
    CardTheme cardTheme,
    ChipThemeData chipTheme,
    TargetPlatform platform,
    MaterialTapTargetSize materialTapTargetSize,
    PageTransitionsTheme pageTransitionsTheme,
    AppBarTheme appBarTheme,
    BottomAppBarTheme bottomAppBarTheme,
    ColorScheme colorScheme,
    DialogTheme dialogTheme,
    FloatingActionButtonThemeData floatingActionButtonTheme,
    Typography typography,
    CupertinoThemeData cupertinoOverrideTheme,
    SnackBarThemeData snackBarTheme,
    BottomSheetThemeData bottomSheetTheme,
  }) {
    final rawThemeData = ThemeData(
      brightness: brightness,
      primarySwatch: primarySwatch,
      fontFamily: fontFamily,
      primaryColor: primaryColor,
      primaryColorBrightness: primaryColorBrightness,
      primaryColorLight: primaryColorLight,
      primaryColorDark: primaryColorDark,
      accentColor: accentColor,
      accentColorBrightness: accentColorBrightness,
      canvasColor: canvasColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      bottomAppBarColor: bottomAppBarColor,
      cardColor: cardColor,
      dividerColor: dividerColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      splashFactory: splashFactory,
      selectedRowColor: selectedRowColor,
      unselectedWidgetColor: unselectedWidgetColor,
      disabledColor: disabledColor,
      buttonTheme: buttonTheme,
      buttonColor: buttonColor,
      toggleableActiveColor: toggleableActiveColor,
      secondaryHeaderColor: secondaryHeaderColor,
      textSelectionColor: textSelectionColor,
      cursorColor: cursorColor,
      textSelectionHandleColor: textSelectionHandleColor,
      backgroundColor: backgroundColor,
      dialogBackgroundColor: dialogBackgroundColor,
      indicatorColor: indicatorColor,
      hintColor: hintColor,
      errorColor: errorColor,
      textTheme: textTheme,
      primaryTextTheme: primaryTextTheme,
      accentTextTheme: accentTextTheme,
      inputDecorationTheme: inputDecorationTheme,
      iconTheme: iconTheme,
      primaryIconTheme: primaryIconTheme,
      accentIconTheme: accentIconTheme,
      sliderTheme: sliderTheme,
      tabBarTheme: tabBarTheme,
      cardTheme: cardTheme,
      chipTheme: chipTheme,
      platform: platform,
      materialTapTargetSize: materialTapTargetSize,
      pageTransitionsTheme: pageTransitionsTheme,
      appBarTheme: appBarTheme,
      bottomAppBarTheme: bottomAppBarTheme,
      colorScheme: colorScheme,
      dialogTheme: dialogTheme,
      floatingActionButtonTheme: floatingActionButtonTheme,
      typography: typography,
      cupertinoOverrideTheme: cupertinoOverrideTheme,
      snackBarTheme: snackBarTheme,
      bottomSheetTheme: bottomSheetTheme,
    );

    backgroundColors ??= [
      rawThemeData.backgroundColor,
      rawThemeData.backgroundColor,
    ];
    zefyrThemeData ??= ZefyrThemeData();
    bottomNavigationBarColor ??= rawThemeData.backgroundColor;
    return StickyThemeData.fromThemeData(
      zefyrThemeData: zefyrThemeData,
      backgroundColors: backgroundColors,
      backgroundImage: backgroundImage,
      bottomNavigationBarColor: bottomNavigationBarColor,
      data: rawThemeData,
    );
  }

  factory StickyThemeData.fromThemeData({
    Uri backgroundImage,
    List<Color> backgroundColors,
    ZefyrThemeData zefyrThemeData,
    Color bottomNavigationBarColor,
    ThemeData data,
  }) {
    backgroundColors ??= [
      data.backgroundColor,
      data.backgroundColor,
    ];
    zefyrThemeData ??= ZefyrThemeData();
    return StickyThemeData.raw(
      bottomNavigationBarColor: bottomNavigationBarColor,
      zefyrThemeData: zefyrThemeData,
      backgroundColors: backgroundColors,
      backgroundImage: backgroundImage,
      brightness: data.brightness,
      primaryColor: data.primaryColor,
      primaryColorBrightness: data.primaryColorBrightness,
      primaryColorLight: data.primaryColorLight,
      primaryColorDark: data.primaryColorDark,
      accentColor: data.accentColor,
      accentColorBrightness: data.accentColorBrightness,
      canvasColor: data.canvasColor,
      scaffoldBackgroundColor: data.scaffoldBackgroundColor,
      bottomAppBarColor: data.bottomAppBarColor,
      cardColor: data.cardColor,
      dividerColor: data.dividerColor,
      focusColor: data.focusColor,
      hoverColor: data.hoverColor,
      highlightColor: data.highlightColor,
      splashColor: data.splashColor,
      splashFactory: data.splashFactory,
      selectedRowColor: data.selectedRowColor,
      unselectedWidgetColor: data.unselectedWidgetColor,
      disabledColor: data.disabledColor,
      buttonTheme: data.buttonTheme,
      buttonColor: data.buttonColor,
      toggleableActiveColor: data.toggleableActiveColor,
      secondaryHeaderColor: data.secondaryHeaderColor,
      textSelectionColor: data.textSelectionColor,
      cursorColor: data.cursorColor,
      textSelectionHandleColor: data.textSelectionHandleColor,
      backgroundColor: data.backgroundColor,
      dialogBackgroundColor: data.dialogBackgroundColor,
      indicatorColor: data.indicatorColor,
      hintColor: data.hintColor,
      errorColor: data.errorColor,
      textTheme: data.textTheme,
      primaryTextTheme: data.primaryTextTheme,
      accentTextTheme: data.accentTextTheme,
      inputDecorationTheme: data.inputDecorationTheme,
      iconTheme: data.iconTheme,
      primaryIconTheme: data.primaryIconTheme,
      accentIconTheme: data.accentIconTheme,
      sliderTheme: data.sliderTheme,
      tabBarTheme: data.tabBarTheme,
      cardTheme: data.cardTheme,
      chipTheme: data.chipTheme,
      platform: data.platform,
      materialTapTargetSize: data.materialTapTargetSize,
      pageTransitionsTheme: data.pageTransitionsTheme,
      appBarTheme: data.appBarTheme,
      bottomAppBarTheme: data.bottomAppBarTheme,
      colorScheme: data.colorScheme,
      dialogTheme: data.dialogTheme,
      floatingActionButtonTheme: data.floatingActionButtonTheme,
      typography: data.typography,
      cupertinoOverrideTheme: data.cupertinoOverrideTheme,
      snackBarTheme: data.snackBarTheme,
      bottomSheetTheme: data.bottomSheetTheme,
    );
  }

  const StickyThemeData.raw({
    @required this.backgroundImage,
    @required this.backgroundColors,
    @required this.zefyrThemeData,
    @required this.bottomNavigationBarColor,
    @required Brightness brightness,
    @required Color primaryColor,
    @required Brightness primaryColorBrightness,
    @required Color primaryColorLight,
    @required Color primaryColorDark,
    @required Color accentColor,
    @required Brightness accentColorBrightness,
    @required Color canvasColor,
    @required Color scaffoldBackgroundColor,
    @required Color bottomAppBarColor,
    @required Color cardColor,
    @required Color dividerColor,
    @required Color focusColor,
    @required Color hoverColor,
    @required Color highlightColor,
    @required Color splashColor,
    @required InteractiveInkFeatureFactory splashFactory,
    @required Color selectedRowColor,
    @required Color unselectedWidgetColor,
    @required Color disabledColor,
    @required Color buttonColor,
    @required ButtonThemeData buttonTheme,
    @required Color secondaryHeaderColor,
    @required Color textSelectionColor,
    @required Color cursorColor,
    @required Color textSelectionHandleColor,
    @required Color backgroundColor,
    @required Color dialogBackgroundColor,
    @required Color indicatorColor,
    @required Color hintColor,
    @required Color errorColor,
    @required Color toggleableActiveColor,
    @required TextTheme textTheme,
    @required TextTheme primaryTextTheme,
    @required TextTheme accentTextTheme,
    @required InputDecorationTheme inputDecorationTheme,
    @required IconThemeData iconTheme,
    @required IconThemeData primaryIconTheme,
    @required IconThemeData accentIconTheme,
    @required SliderThemeData sliderTheme,
    @required TabBarTheme tabBarTheme,
    @required CardTheme cardTheme,
    @required ChipThemeData chipTheme,
    @required TargetPlatform platform,
    @required MaterialTapTargetSize materialTapTargetSize,
    @required PageTransitionsTheme pageTransitionsTheme,
    @required AppBarTheme appBarTheme,
    @required BottomAppBarTheme bottomAppBarTheme,
    @required ColorScheme colorScheme,
    @required DialogTheme dialogTheme,
    @required FloatingActionButtonThemeData floatingActionButtonTheme,
    @required Typography typography,
    @required CupertinoThemeData cupertinoOverrideTheme,
    @required SnackBarThemeData snackBarTheme,
    @required BottomSheetThemeData bottomSheetTheme,
  }) : super.raw(
          brightness: brightness,
          primaryColor: primaryColor,
          primaryColorBrightness: primaryColorBrightness,
          primaryColorLight: primaryColorLight,
          primaryColorDark: primaryColorDark,
          accentColor: accentColor,
          accentColorBrightness: accentColorBrightness,
          canvasColor: canvasColor,
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          bottomAppBarColor: bottomAppBarColor,
          cardColor: cardColor,
          dividerColor: dividerColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          splashFactory: splashFactory,
          selectedRowColor: selectedRowColor,
          unselectedWidgetColor: unselectedWidgetColor,
          disabledColor: disabledColor,
          buttonTheme: buttonTheme,
          buttonColor: buttonColor,
          toggleableActiveColor: toggleableActiveColor,
          secondaryHeaderColor: secondaryHeaderColor,
          textSelectionColor: textSelectionColor,
          cursorColor: cursorColor,
          textSelectionHandleColor: textSelectionHandleColor,
          backgroundColor: backgroundColor,
          dialogBackgroundColor: dialogBackgroundColor,
          indicatorColor: indicatorColor,
          hintColor: hintColor,
          errorColor: errorColor,
          textTheme: textTheme,
          primaryTextTheme: primaryTextTheme,
          accentTextTheme: accentTextTheme,
          inputDecorationTheme: inputDecorationTheme,
          iconTheme: iconTheme,
          primaryIconTheme: primaryIconTheme,
          accentIconTheme: accentIconTheme,
          sliderTheme: sliderTheme,
          tabBarTheme: tabBarTheme,
          cardTheme: cardTheme,
          chipTheme: chipTheme,
          platform: platform,
          materialTapTargetSize: materialTapTargetSize,
          pageTransitionsTheme: pageTransitionsTheme,
          appBarTheme: appBarTheme,
          bottomAppBarTheme: bottomAppBarTheme,
          colorScheme: colorScheme,
          dialogTheme: dialogTheme,
          floatingActionButtonTheme: floatingActionButtonTheme,
          typography: typography,
          cupertinoOverrideTheme: cupertinoOverrideTheme,
          snackBarTheme: snackBarTheme,
          bottomSheetTheme: bottomSheetTheme,
        );

  // WARNING override super class method!
  @override
  StickyThemeData copyWith(
      {Uri backgroundImage,
      List<Color> backgroundColors,
      ZefyrThemeData zefyrThemeData,
      Color bottomNavigationBarColor,
      Brightness brightness,
      Color primaryColor,
      Brightness primaryColorBrightness,
      Color primaryColorLight,
      Color primaryColorDark,
      Color accentColor,
      Brightness accentColorBrightness,
      Color canvasColor,
      Color scaffoldBackgroundColor,
      Color bottomAppBarColor,
      Color cardColor,
      Color dividerColor,
      Color focusColor,
      Color hoverColor,
      Color highlightColor,
      Color splashColor,
      InteractiveInkFeatureFactory splashFactory,
      Color selectedRowColor,
      Color unselectedWidgetColor,
      Color disabledColor,
      ButtonThemeData buttonTheme,
      Color buttonColor,
      Color secondaryHeaderColor,
      Color textSelectionColor,
      Color cursorColor,
      Color textSelectionHandleColor,
      Color backgroundColor,
      Color dialogBackgroundColor,
      Color indicatorColor,
      Color hintColor,
      Color errorColor,
      Color toggleableActiveColor,
      TextTheme textTheme,
      TextTheme primaryTextTheme,
      TextTheme accentTextTheme,
      InputDecorationTheme inputDecorationTheme,
      IconThemeData iconTheme,
      IconThemeData primaryIconTheme,
      IconThemeData accentIconTheme,
      SliderThemeData sliderTheme,
      TabBarTheme tabBarTheme,
      CardTheme cardTheme,
      ChipThemeData chipTheme,
      TargetPlatform platform,
      MaterialTapTargetSize materialTapTargetSize,
      PageTransitionsTheme pageTransitionsTheme,
      AppBarTheme appBarTheme,
      BottomAppBarTheme bottomAppBarTheme,
      ColorScheme colorScheme,
      DialogTheme dialogTheme,
      FloatingActionButtonThemeData floatingActionButtonTheme,
      Typography typography,
      CupertinoThemeData cupertinoOverrideTheme,
      SnackBarThemeData snackBarTheme,
      BottomSheetThemeData bottomSheetTheme}) {
    final rawThemeData = super.copyWith(
      brightness: brightness,
      primaryColor: primaryColor,
      primaryColorBrightness: primaryColorBrightness,
      primaryColorLight: primaryColorLight,
      primaryColorDark: primaryColorDark,
      accentColor: accentColor,
      accentColorBrightness: accentColorBrightness,
      canvasColor: canvasColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      bottomAppBarColor: bottomAppBarColor,
      cardColor: cardColor,
      dividerColor: dividerColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      splashFactory: splashFactory,
      selectedRowColor: selectedRowColor,
      unselectedWidgetColor: unselectedWidgetColor,
      disabledColor: disabledColor,
      buttonTheme: buttonTheme,
      buttonColor: buttonColor,
      toggleableActiveColor: toggleableActiveColor,
      secondaryHeaderColor: secondaryHeaderColor,
      textSelectionColor: textSelectionColor,
      cursorColor: cursorColor,
      textSelectionHandleColor: textSelectionHandleColor,
      backgroundColor: backgroundColor,
      dialogBackgroundColor: dialogBackgroundColor,
      indicatorColor: indicatorColor,
      hintColor: hintColor,
      errorColor: errorColor,
      textTheme: textTheme,
      primaryTextTheme: primaryTextTheme,
      accentTextTheme: accentTextTheme,
      inputDecorationTheme: inputDecorationTheme,
      iconTheme: iconTheme,
      primaryIconTheme: primaryIconTheme,
      accentIconTheme: accentIconTheme,
      sliderTheme: sliderTheme,
      tabBarTheme: tabBarTheme,
      cardTheme: cardTheme,
      chipTheme: chipTheme,
      platform: platform,
      materialTapTargetSize: materialTapTargetSize,
      pageTransitionsTheme: pageTransitionsTheme,
      appBarTheme: appBarTheme,
      bottomAppBarTheme: bottomAppBarTheme,
      colorScheme: colorScheme,
      dialogTheme: dialogTheme,
      floatingActionButtonTheme: floatingActionButtonTheme,
      typography: typography,
      cupertinoOverrideTheme: cupertinoOverrideTheme,
      snackBarTheme: snackBarTheme,
      bottomSheetTheme: bottomSheetTheme,
    );
    return StickyThemeData.fromThemeData(
      zefyrThemeData: zefyrThemeData ?? this.zefyrThemeData,
      backgroundColors: backgroundColors ?? this.backgroundColors,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      bottomNavigationBarColor:
          bottomNavigationBarColor ?? this.bottomNavigationBarColor,
      data: rawThemeData,
    );
  }
}
