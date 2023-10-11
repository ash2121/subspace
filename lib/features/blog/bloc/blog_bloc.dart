import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:subspace/features/blog/model/blog_data_ui_model.dart';
import 'package:subspace/features/blog/repository/blog_repo.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc() : super(BlogInitial()) {
    on<BlogInitialFetchEvent>(blogInitialFetchEvent);
  }

  FutureOr<void> blogInitialFetchEvent(
      BlogInitialFetchEvent event, Emitter<BlogState> emit) async {
    emit(BlogFtechingLoadingState());
    List<BlogDataModel> blogs = await BlogRepo.fetchBlogs();
    if (blogs.isEmpty) emit(BlogFtechingErrorState());
    emit(BlogFetchSuccessfulState(blogs: blogs));
  }
}
