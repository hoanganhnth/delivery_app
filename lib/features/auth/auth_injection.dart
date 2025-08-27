import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import 'data/datasources/auth_remote_datasource.dart';
import 'data/datasources/auth_remote_datasource_impl.dart';
import 'data/repositories_impl/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/register_usecase.dart';
import 'domain/usecases/refresh_token_usecase.dart';

class AuthInjection {
  static late Dio _dio;
  static late AuthApiService _authApiService;
  static late AuthRemoteDataSource _authRemoteDataSource;
  static late AuthRepository _authRepository;
  static late LoginUseCase _loginUseCase;
  static late RegisterUseCase _registerUseCase;
  static late RefreshTokenUseCase _refreshTokenUseCase;

  static void init({
    Future<String?> Function()? getToken,
    Future<String?> Function()? onRefreshToken,
  }) {
    // Initialize Dio client
    final dioClient = DioClient(
      getToken: getToken,
      onRefreshToken: onRefreshToken,
    );
    _dio = dioClient.dio;

    // Initialize API service
    _authApiService = AuthApiService(_dio);

    // Initialize data source
    _authRemoteDataSource = AuthRemoteDataSourceImpl(_authApiService);

    // Initialize repository
    _authRepository = AuthRepositoryImpl(_authRemoteDataSource);

    // Initialize use cases
    _loginUseCase = LoginUseCase(_authRepository);
    _registerUseCase = RegisterUseCase(_authRepository);
    _refreshTokenUseCase = RefreshTokenUseCase(_authRepository);
  }

  // Getters for dependencies
  static Dio get dio => _dio;
  static AuthApiService get authApiService => _authApiService;
  static AuthRemoteDataSource get authRemoteDataSource => _authRemoteDataSource;
  static AuthRepository get authRepository => _authRepository;
  static LoginUseCase get loginUseCase => _loginUseCase;
  static RegisterUseCase get registerUseCase => _registerUseCase;
  static RefreshTokenUseCase get refreshTokenUseCase => _refreshTokenUseCase;
}
