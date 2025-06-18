import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/detailsAboutProperty/domain/repos/get%20property/get_property_repo.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/manager/get%20property/get_property_state.dart';
import '../../../../../core/error/failure.dart';

class GetPropertyCubit extends Cubit<GetPropertyState> {
  final GetPropertyRepo getPropertyRepo;

  Property? _cachedProperty;

  List<Property> publishedProperties = [];
  List<Property> pendingProperties = [];
  List<Property> deletedProperties = [];

  GetPropertyCubit(this.getPropertyRepo) : super(GetPropertyStateInitial());

  Future<void> getPropertyDetails({
    required int id,
    bool forceRefresh = false,
  }) async {
    emit(GetPropertyStateLoading());

    if (_cachedProperty != null && !forceRefresh) {
      emit(GetPropertyStateSuccess(propertyDetails: _cachedProperty!));
      return;
    }

    final Either<Failure, Property> result = await getPropertyRepo.getProperty(id: id);

    result.fold(
          (failure) {
        emit(GetPropertyStateFailure(errorMessage: failure.errorMessage));
      },
          (property) {
        _cachedProperty = property;
        emit(GetPropertyStateSuccess(propertyDetails: property));
      },
    );
  }

  Future<void> getProperties({
    bool forceRefresh = false,
    int index = 0,
    String? id,
  }) async {
    emit(GetPropertyStateLoading());

    if (!forceRefresh && _hasCachedList(index)) {
      emit(GetPropertyStateSuccess(properties: _getCachedList(index)));
      return;
    }

    final Either<Failure, List<Property>> result = await getPropertyRepo.getProperties(index, id: id);

    result.fold(
          (failure) {
        emit(GetPropertyStateFailure(errorMessage: failure.errorMessage));
      },
          (properties) {
        _cacheList(index, properties);
        emit(GetPropertyStateSuccess(properties: properties));
      },
    );
  }

  void _cacheList(int index, List<Property> properties) {
    switch (index) {
      case 0:
        publishedProperties = properties;
        break;
      case 1:
        pendingProperties = properties;
        break;
      case 2:
        deletedProperties = properties;
        break;
    }
  }

  List<Property> _getCachedList(int index) {
    switch (index) {
      case 0:
        return publishedProperties;
      case 1:
        return pendingProperties;
      case 2:
        return deletedProperties;
      default:
        return [];
    }
  }

  bool _hasCachedList(int index) {
    return _getCachedList(index).isNotEmpty;
  }

  int getPropertiesLengthByIndex(int index) {
    return _getCachedList(index).length;
  }

  Future<void> refreshProperty(int id) async {
    await getPropertyDetails(id: id, forceRefresh: true);
  }
}
