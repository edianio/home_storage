class Either<L, R> {
  final L? fail;
  final R? success;

  const Either(this.fail, this.success);

  bool get isFail => fail != null;
  bool get isRight => success != null;

  Either<L, R> fold(L Function() ifFail, R Function() ifRight) {
    if (isFail) {
      return Either(ifFail(), null);
    } else {
      return Either(null, ifRight());
    }
  }

  @override
  String toString() => 'Either($fail, $success)';
}
