String prependAuthorityDelimiterIfMissing(String input) {
  return input.contains('://') ? input : '//$input';
}
