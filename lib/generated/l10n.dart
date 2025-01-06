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

  /// `STT`
  String get stt {
    return Intl.message(
      'STT',
      name: 'stt',
      desc: '',
      args: [],
    );
  }

  /// `Qty actual`
  String get qty_actual {
    return Intl.message(
      'Qty actual',
      name: 'qty_actual',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Performer`
  String get Performer {
    return Intl.message(
      'Performer',
      name: 'Performer',
      desc: '',
      args: [],
    );
  }

  /// `Actual receive`
  String get actual_receive {
    return Intl.message(
      'Actual receive',
      name: 'actual_receive',
      desc: '',
      args: [],
    );
  }

  /// `Urgent`
  String get urgent {
    return Intl.message(
      'Urgent',
      name: 'urgent',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get status_new {
    return Intl.message(
      'New',
      name: 'status_new',
      desc: '',
      args: [],
    );
  }

  /// `Import`
  String get import {
    return Intl.message(
      'Import',
      name: 'import',
      desc: '',
      args: [],
    );
  }

  /// `Export`
  String get export {
    return Intl.message(
      'Export',
      name: 'export',
      desc: '',
      args: [],
    );
  }

  /// `Please enter actual quantity received`
  String get please_enter_qty_actual {
    return Intl.message(
      'Please enter actual quantity received',
      name: 'please_enter_qty_actual',
      desc: '',
      args: [],
    );
  }

  /// `Enter quantity`
  String get enter_quantity {
    return Intl.message(
      'Enter quantity',
      name: 'enter_quantity',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Name product`
  String get name_product {
    return Intl.message(
      'Name product',
      name: 'name_product',
      desc: '',
      args: [],
    );
  }

  /// `change performer`
  String get change_performxer {
    return Intl.message(
      'change performer',
      name: 'change_performxer',
      desc: '',
      args: [],
    );
  }

  /// `import and export of goods`
  String get import_export {
    return Intl.message(
      'import and export of goods',
      name: 'import_export',
      desc: '',
      args: [],
    );
  }

  /// `Unit of calculation`
  String get uoc {
    return Intl.message(
      'Unit of calculation',
      name: 'uoc',
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
