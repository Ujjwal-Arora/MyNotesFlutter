class CloudStorageExceptions implements Exception {
  const CloudStorageExceptions();
}

//c
class CouldNotCreateNoteException extends CloudStorageExceptions {}
//r
class CouldNotGetAllNotesException extends CloudStorageExceptions {}
//u
class CouldNotUpdateNoteException extends CloudStorageExceptions{}
//d
class CouldNotDeleteNoteException extends CloudStorageExceptions{}



