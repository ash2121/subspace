part of 'blog_bloc.dart';

abstract class BlogState {}

abstract class BlogActionState extends BlogState {}

final class BlogInitial extends BlogState {}

final class BlogFtechingLoadingState extends BlogState {}

final class BlogFtechingErrorState extends BlogState {}

final class BlogFetchSuccessfulState extends BlogState {
  final List<BlogDataModel> blogs;

  BlogFetchSuccessfulState({required this.blogs});
}
