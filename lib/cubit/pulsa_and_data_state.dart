part of 'pulsa_and_data_cubit.dart';

sealed class PulsaAndDataState extends Equatable {
  const PulsaAndDataState({ required this.isLoading, required this.productData });

  final bool isLoading;
  final GetProductByTujuanResponse productData;

  @override
  List<Object> get props => [
    isLoading,
    productData
  ];
}

final class PulsaAndDataInitial extends PulsaAndDataState {
  final bool isLoadingState;
  final GetProductByTujuanResponse productDataState;

  const PulsaAndDataInitial({ required this.isLoadingState, required this.productDataState }) : super(
    isLoading: isLoadingState, productData: productDataState
  );
}
