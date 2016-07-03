> This a sample project demonstrating the issues logged in [rdar://27141382](http://www.openradar.me/27141382)

# Realm SwiftFetchedResultsController conversion to Swift 3 - issues

Attempting to convert the `SwiftFetchedResultsController` pod (part of [`RBQFetchedResultsController`](https://github.com/Roobiq/RBQFetchedResultsController)) to Swift 3 and ran into what seems to be a bug in either Xcode, the swift compiler or both.

## Project Setup

This repo has [`realm-cocoa`](https://github.com/realm/realm-cocoa) added as a submodule. Run the following command before attempting to build the project in Xcode.

```
git submodule update --init
```

## Before

```swift
    public func fetchObjects() -> Results<T> {

        var fetchResults = self.realm.objects(T)
                                      ^
```

![](images/1-before.png)

### Initial fix-it

![](images/2-fixit.png)

## After manual conversion

In the updated Swift 3 compatible RealmSwift API the method in question has the following signature.

```swift
public final class Realm {
  public func allObjects<T: Object>(ofType type: T.Type) -> Results<T>
}
```

Manually converting the callsite yields the following code, which should compile, but instead gives new errors.

```swift
    public func fetchObjects() -> Results<T> {

        var fetchResults = self.realm.allObjects(ofType: T.Type)
                                                 ^
```

### 2 errors

![](images/3-errors.png)
![](images/4-errors.png)

```
FetchRequest.swift:108:50: error: cannot create a single-element tuple with an element label
        var fetchResults = self.realm.allObjects(ofType: T.Type)
                                                 ^~~~~~~~

FetchRequest.swift:108:49: error: missing argument label 'ofType:' in call
        var fetchResults = self.realm.allObjects(ofType: T.Type)
                                                ^
                                                ofType:
```

### Fix-it

The fix-it for the above errors generates the following invalid code.

```swift
var fetchResults = self.realm.allObjectsofType: (ofType: T.Type)
```

![](images/5-fixit.png)


## License

This repo is licensed under the MIT License. See the [LICENSE](LICENSE.md) file for rights and limitations.

