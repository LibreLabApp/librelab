String castColumnToText(String column) {
  return '$column::text AS $column';
}

String arrayAggAsText({required String expression, required String alias}) {
  return 'array_agg($expression::text) AS $alias';
}
