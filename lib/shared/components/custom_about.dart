// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:io' show Platform;

import 'package:environ/shared/constants.dart';
import 'package:environ/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void showCustomAboutDialog({
  required BuildContext context,
  String? applicationName,
  String? applicationVersion,
  Widget? applicationIcon,
  String? applicationLegalese,
  List<Widget>? children,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
}) {
  showDialog<void>(
    context: context,
    useRootNavigator: useRootNavigator,
    builder: (context) => CustomAboutDialog(
      applicationName: applicationName,
      applicationVersion: applicationVersion,
      applicationIcon: applicationIcon,
      applicationLegalese: applicationLegalese,
      children: children,
    ),
    routeSettings: routeSettings,
  );
}

void showCustomLicensePage({
  required BuildContext context,
  String? applicationName,
  String? applicationVersion,
  Widget? applicationIcon,
  String? applicationLegalese,
  bool useRootNavigator = false,
}) {
  Navigator.of(context, rootNavigator: useRootNavigator)
      .push(MaterialPageRoute<void>(
    builder: (context) => CustomLicensePage(
      applicationName: applicationName,
      applicationVersion: applicationVersion,
      applicationIcon: applicationIcon,
      applicationLegalese: applicationLegalese,
    ),
  ));
}

const double _textVerticalSeparation = 18;

class CustomAboutDialog extends StatelessWidget {
  const CustomAboutDialog({
    Key? key,
    this.applicationName,
    this.applicationVersion,
    this.applicationIcon,
    this.applicationLegalese,
    this.children,
  }) : super(key: key);
  final String? applicationName;
  final String? applicationVersion;
  final Widget? applicationIcon;
  final String? applicationLegalese;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    final String name = applicationName ?? _defaultApplicationName(context);
    final String version =
        applicationVersion ?? _defaultApplicationVersion(context);
    final Widget? icon = applicationIcon ?? _defaultApplicationIcon(context);
    return AlertDialog(
      content: ListBody(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (icon != null)
                IconTheme(data: Theme.of(context).iconTheme, child: icon),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ListBody(
                    children: <Widget>[
                      Text(name, style: Theme.of(context).textTheme.headline5),
                      Text(version,
                          style: Theme.of(context).textTheme.bodyText2),
                      const SizedBox(height: _textVerticalSeparation),
                      Text(applicationLegalese ?? '',
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ...?children,
        ],
      ),
      actions: <Widget>[
        TextButton(
          child:
              Text(MaterialLocalizations.of(context).viewLicensesButtonLabel),
          onPressed: () {
            showLicensePage(
              context: context,
              applicationName: applicationName,
              applicationVersion: applicationVersion,
              applicationIcon: applicationIcon,
              applicationLegalese: applicationLegalese,
            );
          },
        ),
        TextButton(
          child: Text(MaterialLocalizations.of(context).closeButtonLabel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
      scrollable: true,
    );
  }
}

class CustomLicensePage extends StatefulWidget {
  const CustomLicensePage({
    Key? key,
    this.applicationName,
    this.applicationVersion,
    this.applicationIcon,
    this.applicationLegalese,
  }) : super(key: key);

  /// The name of the application.
  ///
  /// Defaults to the value of [Title.title], if a [Title] widget can be found.
  /// Otherwise, defaults to [Platform.resolvedExecutable].
  final String? applicationName;

  /// The version of this build of the application.
  ///
  /// This string is shown under the application name.
  ///
  /// Defaults to the empty string.
  final String? applicationVersion;

  /// The icon to show below the application name.
  ///
  /// By default no icon is shown.
  ///
  /// Typically this will be an [ImageIcon] widget. It should honor the
  /// [IconTheme]'s [IconThemeData.size].
  final Widget? applicationIcon;

  /// A string to show in small print.
  ///
  /// Typically this is a copyright notice.
  ///
  /// Defaults to the empty string.
  final String? applicationLegalese;

  @override
  State<CustomLicensePage> createState() => _CustomLicensePageState();
}

class _CustomLicensePageState extends State<CustomLicensePage> {
  final ValueNotifier<int?> selectedId = ValueNotifier<int?>(null);

  @override
  Widget build(BuildContext context) => _CustomMasterDetailFlow(
        detailPageFABlessGutterWidth: _getGutterSize(context),
        title: Text(MaterialLocalizations.of(context).licensesPageTitle),
        detailPageBuilder: _packageLicensePage,
        masterViewBuilder: _packagesView,
      );

  Widget _packageLicensePage(
      BuildContext _, Object? args, ScrollController? scrollController) {
    final _CustomDetailArguments detailArguments =
        args! as _CustomDetailArguments;
    return _CustomPackageLicensePage(
      packageName: detailArguments.packageName,
      licenseEntries: detailArguments.licenseEntries,
      scrollController: scrollController,
    );
  }

  Widget _packagesView(final BuildContext _, final bool isLateral) {
    final Widget about = _CustomAboutProgram(
      name: widget.applicationName ?? _defaultApplicationName(context),
      icon: widget.applicationIcon ?? _defaultApplicationIcon(context),
      version: widget.applicationVersion ?? _defaultApplicationVersion(context),
      legalese: widget.applicationLegalese,
    );
    return _CustomPackagesView(
      about: about,
      isLateral: isLateral,
      selectedId: selectedId,
    );
  }
}

class _CustomAboutProgram extends StatelessWidget {
  const _CustomAboutProgram({
    required this.name,
    required this.version,
    this.icon,
    this.legalese,
    Key? key,
  }) : super(key: key);

  final String name;
  final String version;
  final Widget? icon;
  final String? legalese;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _getGutterSize(context),
        vertical: 24,
      ),
      child: Column(
        children: <Widget>[
          Text(
            name,
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          if (icon != null)
            IconTheme(data: Theme.of(context).iconTheme, child: icon!),
          Text(
            version,
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: _textVerticalSeparation),
          Text(
            legalese ?? '',
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: _textVerticalSeparation),
          Text(
            'Powered by Flutter',
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _CustomPackagesView extends StatefulWidget {
  const _CustomPackagesView({
    Key? key,
    required this.about,
    required this.isLateral,
    required this.selectedId,
  }) : super(key: key);

  final Widget about;
  final bool isLateral;
  final ValueNotifier<int?> selectedId;

  @override
  _CustomPackagesViewState createState() => _CustomPackagesViewState();
}

class _CustomPackagesViewState extends State<_CustomPackagesView> {
  final Future<_CustomLicenseData> licenses = LicenseRegistry.licenses
      .fold<_CustomLicenseData>(
        _CustomLicenseData(),
        (prev, license) => prev..addLicense(license),
      )
      .then((licenseData) => licenseData..sortPackages());

  @override
  Widget build(BuildContext context) => FutureBuilder<_CustomLicenseData>(
        future: licenses,
        builder: (context, snapshot) => LayoutBuilder(
          key: ValueKey<ConnectionState>(snapshot.connectionState),
          builder: (context, constraints) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                _initDefaultDetailPage(snapshot.data!, context);
                return ValueListenableBuilder<int?>(
                  valueListenable: widget.selectedId,
                  builder: (context, selectedId, _) {
                    return Center(
                      child: Material(
                        elevation: 4,
                        child: Container(
                          color: themeGreen,
                          constraints:
                              BoxConstraints.loose(const Size.fromWidth(600)),
                          child: _packagesList(context, selectedId,
                              snapshot.data!, widget.isLateral),
                        ),
                      ),
                    );
                  },
                );
              default:
                return const SizedBox(
                  height: double.infinity,
                  child: Loading(),
                );
            }
          },
        ),
      );

  void _initDefaultDetailPage(_CustomLicenseData data, BuildContext context) {
    if (data.packages.isEmpty) {
      return;
    }
    final String packageName = data.packages[widget.selectedId.value ?? 0];
    final List<int> bindings = data.packageLicenseBindings[packageName]!;
    _CustomMasterDetailFlow.of(context)!.setInitialDetailPage(
      _CustomDetailArguments(
        packageName,
        bindings.map((i) => data.licenses[i]).toList(growable: false),
      ),
    );
  }

  Widget _packagesList(
    final BuildContext context,
    final int? selectedId,
    final _CustomLicenseData data,
    final bool drawSelection,
  ) {
    return ListView(
      children: <Widget>[
        widget.about,
        ...data.packages.asMap().entries.map<Widget>((entry) {
          final String packageName = entry.value;
          final int index = entry.key;
          final List<int> bindings = data.packageLicenseBindings[packageName]!;
          return _CustomPackageListTile(
            packageName: packageName,
            index: index,
            isSelected: drawSelection && entry.key == (selectedId ?? 0),
            numberLicenses: bindings.length,
            onTap: () {
              widget.selectedId.value = index;
              _CustomMasterDetailFlow.of(context)!
                  .openDetailPage(_CustomDetailArguments(
                packageName,
                bindings.map((i) => data.licenses[i]).toList(growable: false),
              ));
            },
          );
        }),
      ],
    );
  }
}

class _CustomPackageListTile extends StatelessWidget {
  const _CustomPackageListTile({
    Key? key,
    required this.packageName,
    this.index,
    required this.isSelected,
    required this.numberLicenses,
    this.onTap,
  }) : super(key: key);

  final String packageName;
  final int? index;
  final bool isSelected;
  final int numberLicenses;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(packageName, style: const TextStyle(color: Colors.white)),
        subtitle: Text(MaterialLocalizations.of(context)
            .licensesPackageDetailText(numberLicenses)),
        selected: isSelected,
        onTap: onTap,
      );
}

/// This is a collection of licenses and the packages to which they apply.
/// [packageLicenseBindings] records the m+:n+ relationship between the license
/// and packages as a map of package names to license indexes.
class _CustomLicenseData {
  final List<LicenseEntry> licenses = <LicenseEntry>[];
  final Map<String, List<int>> packageLicenseBindings = <String, List<int>>{};
  final List<String> packages = <String>[];

  // Special treatment for the first package since it should be the package
  // for delivered application.
  String? firstPackage;

  void addLicense(LicenseEntry entry) {
    // Before the license can be added, we must first record the packages to
    // which it belongs.
    for (final String package in entry.packages) {
      _addPackage(package);
      // Bind this license to the package using the next index value. This
      // creates a contract that this license must be inserted at this same
      // index value.
      packageLicenseBindings[package]!.add(licenses.length);
    }
    licenses.add(entry); // Completion of the contract above.
  }

  /// Add a package and initialize package license binding. This is a no-op if
  /// the package has been seen before.
  void _addPackage(String package) {
    if (!packageLicenseBindings.containsKey(package)) {
      packageLicenseBindings[package] = <int>[];
      firstPackage ??= package;
      packages.add(package);
    }
  }

  /// Sort the packages using some comparison method, or by the default manner,
  /// which is to put the application package first, followed by every other
  /// package in case-insensitive alphabetical order.
  void sortPackages([int Function(String a, String b)? compare]) {
    packages.sort(compare ??
        (a, b) {
          // Based on how LicenseRegistry currently behaves, the first package
          // returned is the end user application license. This should be
          // presented first in the list. So here we make sure that first package
          // remains at the front regardless of alphabetical sorting.
          if (a == firstPackage) {
            return -1;
          }
          if (b == firstPackage) {
            return 1;
          }
          return a.toLowerCase().compareTo(b.toLowerCase());
        });
  }
}

@immutable
class _CustomDetailArguments {
  const _CustomDetailArguments(this.packageName, this.licenseEntries);

  final String packageName;
  final List<LicenseEntry> licenseEntries;

  @override
  bool operator ==(final other) {
    if (other is _CustomDetailArguments) {
      return other.packageName == packageName;
    }
    return other == this;
  }

  @override
  int get hashCode => hashValues(packageName, hashList(licenseEntries));
}

class _CustomPackageLicensePage extends StatefulWidget {
  const _CustomPackageLicensePage({
    Key? key,
    required this.packageName,
    required this.licenseEntries,
    required this.scrollController,
  }) : super(key: key);

  final String packageName;
  final List<LicenseEntry> licenseEntries;
  final ScrollController? scrollController;

  @override
  _CustomPackageLicensePageState createState() =>
      _CustomPackageLicensePageState();
}

class _CustomPackageLicensePageState extends State<_CustomPackageLicensePage> {
  @override
  void initState() {
    super.initState();
    _initLicenses();
  }

  final List<Widget> _licenses = <Widget>[];
  bool _loaded = false;

  Future<void> _initLicenses() async {
    assert(() {
      return true;
    }());
    for (final LicenseEntry license in widget.licenseEntries) {
      if (!mounted) {
        return;
      }
      assert(() {
        return true;
      }());
      final List<LicenseParagraph> paragraphs =
          await SchedulerBinding.instance.scheduleTask<List<LicenseParagraph>>(
        license.paragraphs.toList,
        Priority.animation,
        debugLabel: 'License',
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _licenses.add(const Padding(
          padding: EdgeInsets.all(18),
          child: Divider(),
        ));
        for (final LicenseParagraph paragraph in paragraphs) {
          if (paragraph.indent == LicenseParagraph.centeredIndent) {
            _licenses.add(Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                paragraph.text,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ));
          } else {
            assert(paragraph.indent >= 0);
            _licenses.add(Padding(
              padding: EdgeInsetsDirectional.only(
                  top: 8, start: 16.0 * paragraph.indent),
              child: Text(paragraph.text),
            ));
          }
        }
      });
    }
    setState(() {
      _loaded = true;
    });
    assert(() {
      return true;
    }());
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final ThemeData theme = Theme.of(context);
    final String title = widget.packageName;
    final String subtitle =
        localizations.licensesPackageDetailText(widget.licenseEntries.length);
    final double pad = _getGutterSize(context);
    final EdgeInsets padding =
        EdgeInsets.only(left: pad, right: pad, bottom: pad);
    final List<Widget> listWidgets = <Widget>[
      ..._licenses,
      if (!_loaded)
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
    ];

    final Widget page;
    if (widget.scrollController == null) {
      page = Scaffold(
        backgroundColor: themeGreen,
        appBar: AppBar(
          backgroundColor: themeDarkGreen,
          title: _CustomPackageLicensePageTitle(
            title,
            subtitle,
            theme.primaryTextTheme,
          ),
        ),
        body: Center(
          child: Material(
            color: themeGreen,
            elevation: 4,
            child: Container(
              constraints: BoxConstraints.loose(const Size.fromWidth(600)),
              child: Localizations.override(
                locale: const Locale('en', 'US'),
                context: context,
                child: ScrollConfiguration(
                  // A Scrollbar is built-in below.
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: Scrollbar(
                    child: ListView(padding: padding, children: listWidgets),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      page = Container(
        color: themeGreen,
        child: CustomScrollView(
          controller: widget.scrollController,
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              backgroundColor: themeDarkGreen,
              title: _CustomPackageLicensePageTitle(
                  title, subtitle, theme.textTheme),
            ),
            SliverPadding(
              padding: padding,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Localizations.override(
                    locale: const Locale('en', 'US'),
                    context: context,
                    child: listWidgets[index],
                  ),
                  childCount: listWidgets.length,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return DefaultTextStyle(
      style: theme.textTheme.caption!,
      child: page,
    );
  }
}

class _CustomPackageLicensePageTitle extends StatelessWidget {
  const _CustomPackageLicensePageTitle(
    this.title,
    this.subtitle,
    this.theme, {
    Key? key,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: theme.headline6),
        Text(subtitle, style: theme.subtitle2),
      ],
    );
  }
}

String _defaultApplicationName(BuildContext context) {
  // This doesn't handle the case of the application's title dynamically
  // changing. In theory, we should make Title expose the current application
  // title using an InheritedWidget, and so forth. However, in practice, if
  // someone really wants their application title to change dynamically, they
  // can provide an explicit applicationName to the widgets defined in this
  // file, instead of relying on the default.
  final Title? ancestorTitle = context.findAncestorWidgetOfExactType<Title>();
  return ancestorTitle?.title ??
      Platform.resolvedExecutable.split(Platform.pathSeparator).last;
}

String _defaultApplicationVersion(BuildContext context) {
  return '';
}

Widget? _defaultApplicationIcon(BuildContext context) {
  return null;
}

const int _materialGutterThreshold = 720;
const double _wideGutterSize = 24;
const double _narrowGutterSize = 12;

double _getGutterSize(BuildContext context) =>
    MediaQuery.of(context).size.width >= _materialGutterThreshold
        ? _wideGutterSize
        : _narrowGutterSize;

/// Signature for the builder callback used by [_CustomMasterDetailFlow].
typedef _MasterViewBuilder = Widget Function(
    BuildContext context, bool isLateralUI);

/// Signature for the builder callback used by [_CustomMasterDetailFlow.detailPageBuilder].
///
/// scrollController is provided when the page destination is the draggable
/// sheet in the lateral UI. Otherwise, it is null.
typedef _DetailPageBuilder = Widget Function(BuildContext context,
    Object? arguments, ScrollController? scrollController);

/// Signature for the builder callback used by [_CustomMasterDetailFlow.actionBuilder].
///
/// Builds the actions that go in the app bars constructed for the master and
/// lateral UI pages. actionLevel indicates the intended destination of the
/// return actions.
typedef _ActionBuilder = List<Widget> Function(
    BuildContext context, _CustomActionLevel actionLevel);

/// Describes which type of app bar the actions are intended for.
enum _CustomActionLevel {
  /// Indicates the top app bar in the lateral UI.
  top,

  /// Indicates the master view app bar in the lateral UI.
  view,

  /// Indicates the master page app bar in the nested UI.
  composite,
}

/// Describes which layout will be used by [_CustomMasterDetailFlow].
enum _CustomLayoutMode {
  /// Use a nested or lateral layout depending on available screen width.
  auto,

  /// Always use a lateral layout.
  lateral,

  /// Always use a nested layout.
  nested,
}

const String _navMaster = 'master';
const String _navDetail = 'detail';

enum _Focus { master, detail }

/// A Master Detail Flow widget. Depending on screen width it builds either a
/// lateral or nested navigation flow between a master view and a detail page.
/// bloc pattern.
///
/// If focus is on detail view, then switching to nested navigation will
/// populate the navigation history with the master page and the detail page on
/// top. Otherwise the focus is on the master view and just the master page
/// is shown.
class _CustomMasterDetailFlow extends StatefulWidget {
  /// Creates a master detail navigation flow which is either nested or
  /// lateral depending on screen width.
  const _CustomMasterDetailFlow({
    Key? key,
    required this.detailPageBuilder,
    required this.masterViewBuilder,
    this.actionBuilder,
    this.automaticallyImplyLeading = true,
    this.breakpoint,
    this.centerTitle,
    this.detailPageFABGutterWidth,
    this.detailPageFABlessGutterWidth,
    this.displayMode = _CustomLayoutMode.auto,
    this.flexibleSpace,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonMasterPageLocation,
    this.leading,
    this.masterPageBuilder,
    this.masterViewWidth,
    this.title,
  }) : super(key: key);

  /// Builder for the master view for lateral navigation.
  ///
  /// If [masterPageBuilder] is not supplied the master page required for nested navigation, also
  /// builds the master view inside a [Scaffold] with an [AppBar].
  final _MasterViewBuilder masterViewBuilder;

  /// Builder for the master page for nested navigation.
  ///
  /// This builder is usually a wrapper around the [masterViewBuilder] builder to provide the
  /// extra UI required to make a page. However, this builder is optional, and the master page
  /// can be built using the master view builder and the configuration for the lateral UI's app bar.
  final _MasterViewBuilder? masterPageBuilder;

  /// Builder for the detail page.
  ///
  /// If scrollController == null, the page is intended for nested navigation. The lateral detail
  /// page is inside a [DraggableScrollableSheet] and should have a scrollable element that uses
  /// the [ScrollController] provided. In fact, it is strongly recommended the entire lateral
  /// page is scrollable.
  final _DetailPageBuilder detailPageBuilder;

  /// Override the width of the master view in the lateral UI.
  final double? masterViewWidth;

  /// Override the width of the floating action button gutter in the lateral UI.
  final double? detailPageFABGutterWidth;

  /// Override the width of the gutter when there is no floating action button.
  final double? detailPageFABlessGutterWidth;

  /// Add a floating action button to the lateral UI. If no [masterPageBuilder] is supplied, this
  /// floating action button is also used on the nested master page.
  ///
  /// See [Scaffold.floatingActionButton].
  final FloatingActionButton? floatingActionButton;

  /// The title for the lateral UI [AppBar].
  ///
  /// See [AppBar.title].
  final Widget? title;

  /// A widget to display before the title for the lateral UI [AppBar].
  ///
  /// See [AppBar.leading].
  final Widget? leading;

  /// Override the framework from determining whether to show a leading widget or not.
  ///
  /// See [AppBar.automaticallyImplyLeading].
  final bool automaticallyImplyLeading;

  /// Override the framework from determining whether to display the title in the center of the
  /// app bar or not.
  ///
  /// See [AppBar.centerTitle].
  final bool? centerTitle;

  /// See [AppBar.flexibleSpace].
  final Widget? flexibleSpace;

  /// Build actions for the lateral UI, and potentially the master page in the nested UI.
  ///
  /// If level is [_CustomActionLevel.top] then the actions are for
  /// the entire lateral UI page. If level is [_CustomActionLevel.view] the actions
  /// are for the master
  /// view toolbar. Finally, if the [AppBar] for the master page for the nested UI is being built
  /// by [_CustomMasterDetailFlow], then [_CustomActionLevel.composite] indicates the
  /// actions are for the
  /// nested master page.
  final _ActionBuilder? actionBuilder;

  /// Determine where the floating action button will go.
  ///
  /// If null, [FloatingActionButtonLocation.endTop] is used.
  ///
  /// Also see [Scaffold.floatingActionButtonLocation].
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Determine where the floating action button will go on the master page.
  ///
  /// See [Scaffold.floatingActionButtonLocation].
  final FloatingActionButtonLocation? floatingActionButtonMasterPageLocation;

  /// Forces display mode and style.
  final _CustomLayoutMode displayMode;

  /// Width at which layout changes from nested to lateral.
  final double? breakpoint;

  @override
  _CustomMasterDetailFlowState createState() => _CustomMasterDetailFlowState();

  /// The master detail flow proxy from the closest instance of this class that encloses the given
  /// context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// _MasterDetailFlow.of(context).openDetailPage(arguments);
  /// ```
  static _CustomMasterDetailFlowProxy? of(BuildContext context) {
    _CustomPageOpener? pageOpener =
        context.findAncestorStateOfType<_CustomMasterDetailScaffoldState>();
    pageOpener ??=
        context.findAncestorStateOfType<_CustomMasterDetailFlowState>();
    assert(() {
      if (pageOpener == null) {
        throw FlutterError(
          'Master Detail operation requested with a context that does not include a Master Detail '
          'Flow.\nThe context used to open a detail page from the Master Detail Flow must be '
          'that of a widget that is a descendant of a Master Detail Flow widget.',
        );
      }
      return true;
    }());
    return pageOpener != null
        ? _CustomMasterDetailFlowProxy._(pageOpener)
        : null;
  }
}

/// Interface for interacting with the [_CustomMasterDetailFlow].
class _CustomMasterDetailFlowProxy implements _CustomPageOpener {
  _CustomMasterDetailFlowProxy._(this._pageOpener);

  final _CustomPageOpener _pageOpener;

  /// Open detail page with arguments.
  @override
  void openDetailPage(Object arguments) =>
      _pageOpener.openDetailPage(arguments);

  /// Set the initial page to be open for the lateral layout. This can be set at any time, but
  /// will have no effect after any calls to openDetailPage.
  @override
  void setInitialDetailPage(Object arguments) =>
      _pageOpener.setInitialDetailPage(arguments);
}

abstract class _CustomPageOpener {
  void openDetailPage(Object arguments);

  void setInitialDetailPage(Object arguments);
}

const int _materialWideDisplayThreshold = 840;

class _CustomMasterDetailFlowState extends State<_CustomMasterDetailFlow>
    implements _CustomPageOpener {
  /// Tracks whether focus is on the detail or master views. Determines behavior when switching
  /// from lateral to nested navigation.
  _Focus focus = _Focus.master;

  /// Cache of arguments passed when opening a detail page. Used when rebuilding.
  Object? _cachedDetailArguments;

  /// Record of the layout that was built.
  _CustomLayoutMode? _builtLayout;

  /// Key to access navigator in the nested layout.
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void openDetailPage(Object arguments) {
    _cachedDetailArguments = arguments;
    if (_builtLayout == _CustomLayoutMode.nested) {
      _navigatorKey.currentState!.pushNamed(_navDetail, arguments: arguments);
    } else {
      focus = _Focus.detail;
    }
  }

  @override
  void setInitialDetailPage(Object arguments) {
    _cachedDetailArguments = arguments;
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.displayMode) {
      case _CustomLayoutMode.nested:
        return _nestedUI(context);
      case _CustomLayoutMode.lateral:
        return _lateralUI(context);
      case _CustomLayoutMode.auto:
        return LayoutBuilder(builder: (context, constraints) {
          final double availableWidth = constraints.maxWidth;
          if (availableWidth >=
              (widget.breakpoint ?? _materialWideDisplayThreshold)) {
            return _lateralUI(context);
          } else {
            return _nestedUI(context);
          }
        });
    }
  }

  Widget _nestedUI(BuildContext context) {
    _builtLayout = _CustomLayoutMode.nested;
    final MaterialPageRoute<void> masterPageRoute = _masterPageRoute(context);

    return WillPopScope(
      // Push pop check into nested navigator.
      onWillPop: () async => !(await _navigatorKey.currentState!.maybePop()),
      child: Navigator(
        key: _navigatorKey,
        initialRoute: 'initial',
        onGenerateInitialRoutes: (navigator, initialRoute) {
          switch (focus) {
            case _Focus.master:
              return <Route<void>>[masterPageRoute];
            case _Focus.detail:
              return <Route<void>>[
                masterPageRoute,
                _detailPageRoute(_cachedDetailArguments),
              ];
          }
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case _navMaster:
              // Matching state to navigation event.
              focus = _Focus.master;
              return masterPageRoute;
            case _navDetail:
              // Matching state to navigation event.
              focus = _Focus.detail;
              // Cache detail page settings.
              _cachedDetailArguments = settings.arguments;
              return _detailPageRoute(_cachedDetailArguments);
            default:
              throw Exception('Unknown route ${settings.name}');
          }
        },
      ),
    );
  }

  MaterialPageRoute<void> _masterPageRoute(BuildContext context) {
    return MaterialPageRoute<dynamic>(
      builder: (c) => BlockSemantics(
        child: widget.masterPageBuilder != null
            ? widget.masterPageBuilder!(c, false)
            : _CustomMasterPage(
                leading: widget.leading ??
                    (widget.automaticallyImplyLeading &&
                            Navigator.of(context).canPop()
                        ? BackButton(
                            onPressed: () => Navigator.of(context).pop())
                        : null),
                title: widget.title,
                centerTitle: widget.centerTitle,
                flexibleSpace: widget.flexibleSpace,
                automaticallyImplyLeading: widget.automaticallyImplyLeading,
                floatingActionButton: widget.floatingActionButton,
                floatingActionButtonLocation:
                    widget.floatingActionButtonMasterPageLocation,
                masterViewBuilder: widget.masterViewBuilder,
                actionBuilder: widget.actionBuilder,
              ),
      ),
    );
  }

  MaterialPageRoute<void> _detailPageRoute(Object? arguments) {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          // No need for setState() as rebuild happens on navigation pop.
          focus = _Focus.master;
          Navigator.of(context).pop();
          return false;
        },
        child: BlockSemantics(
            child: widget.detailPageBuilder(context, arguments, null)),
      );
    });
  }

  Widget _lateralUI(BuildContext context) {
    _builtLayout = _CustomLayoutMode.lateral;
    return _CustomMasterDetailScaffold(
      actionBuilder: widget.actionBuilder ?? (_, __) => const <Widget>[],
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      centerTitle: widget.centerTitle,
      detailPageBuilder: (context, args, scrollController) =>
          widget.detailPageBuilder(
              context, args ?? _cachedDetailArguments, scrollController),
      floatingActionButton: widget.floatingActionButton,
      detailPageFABlessGutterWidth: widget.detailPageFABlessGutterWidth,
      detailPageFABGutterWidth: widget.detailPageFABGutterWidth,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      initialArguments: _cachedDetailArguments,
      leading: widget.leading,
      masterViewBuilder: (context, isLateral) =>
          widget.masterViewBuilder(context, isLateral),
      masterViewWidth: widget.masterViewWidth,
      title: widget.title,
    );
  }
}

class _CustomMasterPage extends StatelessWidget {
  const _CustomMasterPage({
    Key? key,
    this.leading,
    this.title,
    this.actionBuilder,
    this.centerTitle,
    this.flexibleSpace,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.masterViewBuilder,
    required this.automaticallyImplyLeading,
  }) : super(key: key);

  final _MasterViewBuilder? masterViewBuilder;
  final Widget? title;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final bool? centerTitle;
  final Widget? flexibleSpace;
  final _ActionBuilder? actionBuilder;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeGreen,
      appBar: AppBar(
        backgroundColor: themeDarkGreen,
        title: title,
        leading: leading,
        actions: actionBuilder == null
            ? const <Widget>[]
            : actionBuilder!(context, _CustomActionLevel.composite),
        centerTitle: centerTitle,
        flexibleSpace: flexibleSpace,
        automaticallyImplyLeading: automaticallyImplyLeading,
      ),
      body: masterViewBuilder!(context, false),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}

const double _kCardElevation = 4;
const double _kMasterViewWidth = 320;
const double _kDetailPageFABlessGutterWidth = 40;
const double _kDetailPageFABGutterWidth = 84;

class _CustomMasterDetailScaffold extends StatefulWidget {
  const _CustomMasterDetailScaffold({
    Key? key,
    required this.detailPageBuilder,
    required this.masterViewBuilder,
    this.actionBuilder,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.initialArguments,
    this.leading,
    this.title,
    required this.automaticallyImplyLeading,
    this.centerTitle,
    this.detailPageFABlessGutterWidth,
    this.detailPageFABGutterWidth,
    this.masterViewWidth,
  }) : super(key: key);

  final _MasterViewBuilder masterViewBuilder;

  /// Builder for the detail page.
  ///
  /// The detail page is inside a [DraggableScrollableSheet] and should have a scrollable element
  /// that uses the [ScrollController] provided. In fact, it is strongly recommended the entire
  /// lateral page is scrollable.
  final _DetailPageBuilder detailPageBuilder;
  final _ActionBuilder? actionBuilder;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Object? initialArguments;
  final Widget? leading;
  final Widget? title;
  final bool automaticallyImplyLeading;
  final bool? centerTitle;
  final double? detailPageFABlessGutterWidth;
  final double? detailPageFABGutterWidth;
  final double? masterViewWidth;

  @override
  _CustomMasterDetailScaffoldState createState() =>
      _CustomMasterDetailScaffoldState();
}

class _CustomMasterDetailScaffoldState
    extends State<_CustomMasterDetailScaffold> implements _CustomPageOpener {
  late FloatingActionButtonLocation floatingActionButtonLocation;
  late double detailPageFABGutterWidth;
  late double detailPageFABlessGutterWidth;
  late double masterViewWidth;

  final ValueNotifier<Object?> _detailArguments = ValueNotifier<Object?>(null);

  @override
  void initState() {
    super.initState();
    detailPageFABlessGutterWidth =
        widget.detailPageFABlessGutterWidth ?? _kDetailPageFABlessGutterWidth;
    detailPageFABGutterWidth =
        widget.detailPageFABGutterWidth ?? _kDetailPageFABGutterWidth;
    masterViewWidth = widget.masterViewWidth ?? _kMasterViewWidth;
    floatingActionButtonLocation = widget.floatingActionButtonLocation ??
        FloatingActionButtonLocation.endTop;
  }

  @override
  void openDetailPage(Object arguments) {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => _detailArguments.value = arguments);
    _CustomMasterDetailFlow.of(context)!.openDetailPage(arguments);
  }

  @override
  void setInitialDetailPage(Object arguments) {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => _detailArguments.value = arguments);
    _CustomMasterDetailFlow.of(context)!.setInitialDetailPage(arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: themeGreen,
          floatingActionButtonLocation: floatingActionButtonLocation,
          appBar: AppBar(
            backgroundColor: themeDarkGreen,
            title: widget.title,
            actions: widget.actionBuilder!(context, _CustomActionLevel.top),
            leading: widget.leading,
            automaticallyImplyLeading: widget.automaticallyImplyLeading,
            centerTitle: widget.centerTitle,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Row(
                children: <Widget>[
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: masterViewWidth),
                    child: IconTheme(
                      data: Theme.of(context).primaryIconTheme,
                      child: Container(
                        alignment: AlignmentDirectional.centerEnd,
                        padding: const EdgeInsets.all(8),
                        child: OverflowBar(
                          spacing: 8,
                          overflowAlignment: OverflowBarAlignment.end,
                          children: widget.actionBuilder!(
                              context, _CustomActionLevel.view),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: _masterPanel(context),
          floatingActionButton: widget.floatingActionButton,
        ),
        // Detail view stacked above main scaffold and master view.
        SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: masterViewWidth - _kCardElevation,
              end: widget.floatingActionButton == null
                  ? detailPageFABlessGutterWidth
                  : detailPageFABGutterWidth,
            ),
            child: ValueListenableBuilder<Object?>(
              valueListenable: _detailArguments,
              builder: (context, value, child) {
                return AnimatedSwitcher(
                  transitionBuilder: (child, animation) =>
                      const FadeUpwardsPageTransitionsBuilder()
                          .buildTransitions<void>(
                    null,
                    null,
                    animation,
                    null,
                    child,
                  ),
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    key: ValueKey<Object?>(value ?? widget.initialArguments),
                    constraints: const BoxConstraints.expand(),
                    child: _CustomDetailView(
                      builder: widget.detailPageBuilder,
                      arguments: value ?? widget.initialArguments,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  ConstrainedBox _masterPanel(BuildContext context,
      {bool needsScaffold = false}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: masterViewWidth),
      child: needsScaffold
          ? Scaffold(
              backgroundColor: themeGreen,
              appBar: AppBar(
                backgroundColor: themeDarkGreen,
                title: widget.title,
                actions: widget.actionBuilder!(context, _CustomActionLevel.top),
                leading: widget.leading,
                automaticallyImplyLeading: widget.automaticallyImplyLeading,
                centerTitle: widget.centerTitle,
              ),
              body: widget.masterViewBuilder(context, true),
            )
          : widget.masterViewBuilder(context, true),
    );
  }
}

class _CustomDetailView extends StatelessWidget {
  const _CustomDetailView({
    Key? key,
    required _DetailPageBuilder builder,
    Object? arguments,
  })  : _builder = builder,
        _arguments = arguments,
        super(key: key);

  final _DetailPageBuilder _builder;
  final Object? _arguments;

  @override
  Widget build(BuildContext context) {
    if (_arguments == null) {
      return Container();
    }
    final double screenHeight = MediaQuery.of(context).size.height;
    final double minHeight = (screenHeight - kToolbarHeight) / screenHeight;

    return DraggableScrollableSheet(
      initialChildSize: minHeight,
      minChildSize: minHeight,
      expand: false,
      builder: (context, controller) {
        return MouseRegion(
          child: Card(
            color: Theme.of(context).cardColor,
            elevation: _kCardElevation,
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.fromLTRB(
                _kCardElevation, 0, _kCardElevation, 0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
            ),
            child: _builder(
              context,
              _arguments,
              controller,
            ),
          ),
        );
      },
    );
  }
}
