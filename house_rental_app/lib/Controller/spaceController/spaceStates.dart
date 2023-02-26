import 'package:newproject/Model/spaceModel.dart';

abstract class SpaceStates{}
class InitialSpaceState extends SpaceStates{}
class LoadingSpaceState extends SpaceStates{}
class SuccessSpaceState extends SpaceStates{}
class ErrorSpaceState extends SpaceStates{}

class SuccessAddSpaceState extends SpaceStates{}
class ErrorAddSpaceState extends SpaceStates{}


class SuccessDeleteSpaceState extends SpaceStates{}
class ErrorDeleteSpaceState extends SpaceStates{}

class LoadingUpdateSpaceState extends SpaceStates{}
class SuccessUpdateSpaceState extends SpaceStates{}
class ErrorUpdateSpaceState extends SpaceStates{}

class LoadingGetFavoriteState extends SpaceStates{}
class SuccessGetFavoriteState extends SpaceStates{}
class ErrorGetFavoriteState extends SpaceStates{}


class FavoriteSuccessState extends SpaceStates{}
class FavoriteErrorState extends SpaceStates{}

class ChangePopUpState extends SpaceStates{}


class RecommendSpacesState extends SpaceStates{}
class CategorySpacesState extends SpaceStates{}
class GetDataSpacesState extends SpaceStates{}
