

import UIKit
import CoreData

@objc(Document)
public class Document: NSManagedObject {
    var modifiedDate: Date? {
        get {
            return rawModifiedDate as Date?
        }
        set {
            rawModifiedDate = newValue as NSDate?
        }
    }
    
    convenience init?(name: String?, content: String?, photo: UIImage) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate  //UIKit is needed to access UIApplication
        guard let managedContext = appDelegate?.persistentContainer.viewContext,
            let name = name, name != "" else {
                return nil
        }
        self.init(entity: Document.entity(), insertInto: managedContext)
        self.name = name
        self.content = content
        if let size = content?.count {
            self.size = Int64(size)
        } else {
            self.size = 0
        }
        
        self.modifiedDate = Date(timeIntervalSinceNow: 0)
        
        let imageData = UIImagePNGRepresentation(photo) as NSData!
        self.photo = imageData!
    }
    
    func update(name: String, content: String?, photo: UIImage) {
        self.name = name
        self.content = content
        if let size = content?.count {
            self.size = Int64(size)
        } else {
            self.size = 0
        }
    
        self.modifiedDate = Date(timeIntervalSinceNow: 0)
    }
}
