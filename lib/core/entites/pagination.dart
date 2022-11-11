// ignore_for_file: public_member_api_docs, sort_constructors_first

class Pagination<E> {
  final List<E> content;
  final int quantity;
  final bool hasNextPage;
  final bool hasPreviousPage;

  Pagination({
    required this.content,
    required this.quantity,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });


  

  Pagination<E> copyWith({
    List<E>? content,
    int? quantity,
    bool? hasNextPage,
    bool? hasPreviousPage,
  }) {
    return Pagination<E>(
      content: content ?? this.content,
      quantity: quantity ?? this.quantity,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
    );
  }
  
}
