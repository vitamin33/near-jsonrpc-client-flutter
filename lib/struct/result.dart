abstract class Result <R, E> {
  bool isOk();
  R result();
  E error();
}