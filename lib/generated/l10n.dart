// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `welcome_to_reorder`
  String get welcome_to_reorder {
    return Intl.message(
      'welcome_to_reorder',
      name: 'welcome_to_reorder',
      desc: '',
      args: [],
    );
  }

  /// `Import and Export Good`
  String get import_and_export_good {
    return Intl.message(
      'Import and Export Good',
      name: 'import_and_export_good',
      desc: '',
      args: [],
    );
  }

  /// `Manage Pallet`
  String get manage_pallet {
    return Intl.message(
      'Manage Pallet',
      name: 'manage_pallet',
      desc: '',
      args: [],
    );
  }

  /// `Manage location`
  String get manage_location {
    return Intl.message(
      'Manage location',
      name: 'manage_location',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Virtual qty`
  String get virtual_qty {
    return Intl.message(
      'Virtual qty',
      name: 'virtual_qty',
      desc: '',
      args: [],
    );
  }

  /// `UOM`
  String get uom {
    return Intl.message(
      'UOM',
      name: 'uom',
      desc: '',
      args: [],
    );
  }

  /// `SKU name`
  String get sku_name {
    return Intl.message(
      'SKU name',
      name: 'sku_name',
      desc: '',
      args: [],
    );
  }

  /// `Qty Plan`
  String get qty_plan {
    return Intl.message(
      'Qty Plan',
      name: 'qty_plan',
      desc: '',
      args: [],
    );
  }

  /// `Locator`
  String get locator {
    return Intl.message(
      'Locator',
      name: 'locator',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `SKU Code`
  String get sku {
    return Intl.message(
      'SKU Code',
      name: 'sku',
      desc: '',
      args: [],
    );
  }

  /// `PO Code`
  String get po_code {
    return Intl.message(
      'PO Code',
      name: 'po_code',
      desc: '',
      args: [],
    );
  }

  /// `SO Code`
  String get so_code {
    return Intl.message(
      'SO Code',
      name: 'so_code',
      desc: '',
      args: [],
    );
  }

  /// `Performer`
  String get performer {
    return Intl.message(
      'Performer',
      name: 'performer',
      desc: '',
      args: [],
    );
  }

  /// `Transfer performer`
  String get transfer_performer {
    return Intl.message(
      'Transfer performer',
      name: 'transfer_performer',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
