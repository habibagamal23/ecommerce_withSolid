part of 'localization_cubit.dart';

@immutable
abstract class LocalizationState {
  Locale locale;
  LocalizationState(this.locale);
}

final class LocalizatioInitial extends LocalizationState {
  LocalizatioInitial() : super(Locale('en'));
}

final class LocalizationChange extends LocalizationState {
  final Locale locale;
  LocalizationChange(this.locale) : super(locale);
}
