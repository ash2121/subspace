import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:subspace/features/blog/bloc/blog_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final BlogBloc blogBloc = BlogBloc();
  @override
  void initState() {
    blogBloc.add(BlogInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: Scaffold(
        appBar: AppBar(title: const Text("Subspace by Aditi Maheshwari")),
        body: BlocConsumer<BlogBloc, BlogState>(
          bloc: blogBloc,
          buildWhen: (previous, current) => current is! BlogActionState,
          listenWhen: (previous, current) => current is BlogActionState,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case BlogFtechingLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case BlogFetchSuccessfulState:
                final successState = state as BlogFetchSuccessfulState;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 20.h),
                      margin: EdgeInsets.only(
                          bottom: 10.h, left: 10.w, right: 10.w),
                      height: 310.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        image: DecorationImage(
                          image:
                              NetworkImage(successState.blogs[index].imageUrl),
                          fit: BoxFit.fill,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.6),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Stack(children: [
                        Positioned(
                          top: 240.h,
                          left: 10.w,
                          child: Text(
                            successState.blogs[index].title,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ]),
                    );
                  },
                  itemCount: successState.blogs.length,
                );
              case BlogFtechingErrorState:
                return const Center(
                  child: Text("Cannot load the Blogs. Try again later"),
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
