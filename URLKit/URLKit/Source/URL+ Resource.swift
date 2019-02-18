//
//  URL+ Resource.swift
//  URLKit
//
//  Created by Omar Allaham on 1/28/19.
//  Copyright © 2019 Martian Bears. All rights reserved.
//

import Foundation

extension URL {
    
    public var isRegularFile: Bool? {
        
        return (try? resourceValues(forKeys: [.isRegularFileKey]))?.isRegularFile
    }
    
    public var isDirectory: Bool? {
        
        return (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory
    }
    
    public var isSymbolicLink: Bool? {
        
        return (try? resourceValues(forKeys: [.isSymbolicLinkKey]))?.isSymbolicLink
    }
    
    public var isUserImmutable: Bool? {
        
        return (try? resourceValues(forKeys: [.isUserImmutableKey]))?.isUserImmutable
    }
    
    public var isHidden: Bool? {
        return (try? resourceValues(forKeys: [.isHiddenKey]))?.isHidden
    }
    
    public var creationDate: Date? {
        
        return (try? resourceValues(forKeys: [.creationDateKey]))?.creationDate
    }
    
    public var contentAccessDate: Date? {
        
        return (try? resourceValues(forKeys: [.contentAccessDateKey]))?.contentAccessDate
    }
    
    public var contentModificationDate: Date? {
        
        return (try? resourceValues(forKeys: [.contentModificationDateKey]))?.contentModificationDate
    }
    
    public var attributeModificationDate: Date? {
        
        return (try? resourceValues(forKeys: [.attributeModificationDateKey]))?.attributeModificationDate
    }
    
    public var parentDirectory: URL? {
        return (try? resourceValues(forKeys: [.parentDirectoryURLKey]))?.parentDirectory
    }
    
    public var localizedTypeDescription: String? {
        
        return (try? resourceValues(forKeys: [.localizedTypeDescriptionKey]))?.localizedTypeDescription
    }
    
    public var localizedName: String? {
        
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
    
    public var itemName: String? {
        return (try? resourceValues(forKeys: [.nameKey]))?.name
    }
    
    public var isExcludedFromBackup: Bool? {
        get {
            return (try? resourceValues(forKeys: [.isExcludedFromBackupKey]))?.isExcludedFromBackup
        }
        set {
            var values = URLResourceValues()
            
            values.isExcludedFromBackup = newValue
            
            try? setResourceValues(values)
        }
    }
}

