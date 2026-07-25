/// Represents the synchronization status of an entity in the local database.
enum SyncStatus {
  /// The entity is fully synced with the backend.
  synced,
  
  /// The entity was created locally and needs to be pushed to the backend.
  pendingCreate,
  
  /// The entity was modified locally and needs to be updated on the backend.
  pendingUpdate,
  
  /// The entity was deleted locally and needs to be deleted on the backend.
  pendingDelete,
}
