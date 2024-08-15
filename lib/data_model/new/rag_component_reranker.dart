import 'dart:math';

class RagComponentReranker {
  RagComponentReranker(
      {required this.compactionRate,
      required this.name,
      required this.useCompactionModel,
      required this.rerankedDocuments});

  String name;
  bool useCompactionModel;
  double compactionRate;
  int rerankedDocuments;

  int getRerankedTokens(int inputDocuments, int chunkSize) {
    if (useCompactionModel) {
      return (inputDocuments * chunkSize * compactionRate).round();
    } else {
      return min<int>(inputDocuments, rerankedDocuments) * chunkSize;
    }
  }
}
