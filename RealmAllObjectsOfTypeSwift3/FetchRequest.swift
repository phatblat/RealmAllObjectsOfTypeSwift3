// Extracted from SwiftFetchedResultsController pod, part of:
// https://github.com/Roobiq/RBQFetchedResultsController

import Realm
import RealmSwift


public class FetchRequest<T: Object> {
    /**
     Retrieve all the Objects for this fetch request in its realm.

     @return Results for all the objects in the fetch request (not thread-safe).
     */
    public func fetchObjects() -> Results<T> {

        let fetchResults = self.realm.allObjects(ofType: T.self)

        return fetchResults
    }
}

// MARK: - Stubs
extension FetchRequest {
    var realm: Realm {
        return try! Realm()
    }
}
