import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/utils/local_storage/storage_helper.dart';
import 'package:ecommerce_app/core/utils/service_locator.dart';
import 'package:ecommerce_app/features/auth/repo/auth_repo.dart';

class AppInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // 1. بنيجي هنا قبل ما أي Request يطلع، نسحب الـ Access Token من SecureStorage
    final token = await sl<StorageHelper>().getToken();

    // 2. لو لقيناد موجود، بنحطه في الهيدر بتاع الطلب الحالي
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // 3. بنقول للـ Handler كمل طريقك وابعث الطلب للسيرفر بالهيدر الجديد
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    // 1. بنتحقق: هل الخطأ بسبب ان انتهاء صلاحية التوكين (401 Unauthorized)؟
    if (err.response?.statusCode == 401) {
      final authRepo = sl<AuthRepo>();

      // 2. بنطلب تجديد التوكين في الخلفية
      final result = await authRepo.refreshTokens();

      // 3. لو التجديد نجح (isRight)
      if (result.isRight()) {
        final newAccessToken = result.getOrElse(() => '');

        // بنسحب بيانات الطلب الأصلي اللي اتلغى
        final opts = err.requestOptions;
        // بنحدث الهيدر جواه بالتوكين الجديد
        opts.headers['Authorization'] = 'Bearer $newAccessToken';

        try {
          // بنعمل instance جديد من Dio لإعادة إرسال الطلب المعدل (عشان نتجنب الدخول في Interceptor تاني)
          final dio = Dio();

          final response = await dio.fetch(opts);

          // بنرجع الاستجابة بنجاح للـ UI وكأن الخطأ 401 لم يحدث قط!
          return handler.resolve(response);
        } on DioException catch (e) {
          return handler.next(e);
        } catch (e) {
          return handler.next(err);
        }
      } else {
        // 4. لو التجديد فشل (الـ Refresh Tokens هو كمان انتهى) -> بنمسح بيانات الـ Storage لتسجيل الخروج
        await sl<StorageHelper>().clearAll();
        return handler.next(err);
      }
    }

    // 5. لو الخطأ مش 401 (مثلاً 500 أو 404)، بنمرره للـ UI عادي يتعامل معاه
    return handler.next(err);
  }
}
