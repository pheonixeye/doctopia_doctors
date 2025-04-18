// ignore_for_file: constant_identifier_names

enum VisitFilter {
  year_month_day(
    en: 'Daily',
    ar: 'يومى',
  ),
  year_month(
    en: 'Monthly',
    ar: 'شهرى',
  ),
  year(
    en: 'Yearly',
    ar: 'يومى',
  );

  final String en;
  final String ar;

  const VisitFilter({
    required this.en,
    required this.ar,
  });
}
