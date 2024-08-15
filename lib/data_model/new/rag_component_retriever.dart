class RagComponentRetriever {
  RagComponentRetriever(
      {required this.name, required this.retrievedDocuments, required this.chunkSize});

  String name;
  int retrievedDocuments;
  int chunkSize;

  int getRetrievedTokens() {
    return retrievedDocuments * chunkSize;
  }

  int getTopK() {
    return retrievedDocuments;
  }

  int getChunkSize() {
    return chunkSize;
  }
}
