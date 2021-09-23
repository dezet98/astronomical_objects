extension ObjectExt<T> on T {
  R let<R>(R Function(T it) e) => e(this);
}
