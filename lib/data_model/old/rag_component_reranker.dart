import 'dart:math';

class RagComponentReranker {
  RagComponentReranker(
      {required this.compressionRate,
      required this.name,
      required this.usecompressionModel,
      required this.rerankedDocuments});

  String name;
  bool usecompressionModel;
  double compressionRate;
  int rerankedDocuments;

  int getRerankedTokens(int inputDocuments, int chunkSize) {
    if (usecompressionModel) {
      return (inputDocuments * chunkSize * compressionRate).round();
    } else {
      return min<int>(inputDocuments, rerankedDocuments) * chunkSize;
    }
  }
}
