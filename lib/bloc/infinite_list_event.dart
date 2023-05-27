part of 'infinite_list_bloc.dart';

@immutable
abstract class InfiniteListEvent {}
//TRIAL INFINITE LIST
class ResiFetched extends InfiniteListEvent {}

class ResiRefreshed extends InfiniteListEvent {}