//
//  URL+FileManager.swift
//  URLKit
//
//  Created by Omar Allaham on 1/25/19.
//  Copyright © 2019 Martian Bears. All rights reserved.
//

import Foundation

extension URL {
    
    func fileExists(atPath path: String, isDirectory: UnsafeMutablePointer<ObjCBool>?) -> Bool {
        return FileManager.default.fileExists(atPath: path, isDirectory: isDirectory)
    }
    
    public var fileExists: Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    public func contents(keys: [URLResourceKey]? = nil, options mask: FileManager.DirectoryEnumerationOptions = []) throws -> [URL] {
        return try FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: keys, options: mask)
    }
    
    public static func url(for directory: FileManager.SearchPathDirectory,
                           in domain: FileManager.SearchPathDomainMask = .userDomainMask) -> URL? {
        
        return FileManager.default.urls(for: directory, in: domain).first
    }
    
    func createDirectory(withIntermediateDirectories createIntermediates: Bool = true,
                         attributes: [FileAttributeKey : Any]? = nil) throws {
        
        try FileManager.default.createDirectory(at: self,
                                                withIntermediateDirectories: createIntermediates,
                                                attributes: attributes)
    }
    
    func setAttributes(_ attributes: [FileAttributeKey : Any]) throws {
        
        try FileManager.default.setAttributes(attributes, ofItemAtPath: path)
    }
    
    public var attributes: [FileAttributeKey : Any] {
        return (try? attributesOfItem()) ?? [:]
    }
    
    public func attributesOfItem() throws -> [FileAttributeKey : Any] {
        return try FileManager.default.attributesOfItem(atPath: path)
    }
    
    public func copyItem(to dstURL: URL) throws {
        try FileManager.default.copyItem(at: self, to: dstURL)
    }
    
    public func moveItem(to dstURL: URL) throws {
        try FileManager.default.moveItem(at: self, to: dstURL)
    }
    
    public func linkItem(to dstURL: URL) throws {
        try FileManager.default.linkItem(at: self, to: dstURL)
    }
    
    public func removeItem() throws {
        try FileManager.default.removeItem(at: self)
    }
    
    public mutating func renameItem(to newName: String) throws {

        var values = URLResourceValues()
        
        values.name = newName
        
        try setResourceValues(values)
    }
    
    public func replaceItem(withItemAt newItemURL: URL,
                            backupItemName: String?,
                            options: FileManager.ItemReplacementOptions = [],
                            resultingItemURL resultingURL: AutoreleasingUnsafeMutablePointer<NSURL?>?) throws ->  URL? {
        
        return try FileManager.default.replaceItemAt(self, withItemAt: newItemURL, backupItemName: backupItemName, options: options)
    }
    
    public var enumerator: FileManager.DirectoryEnumerator? {
        return FileManager.default.enumerator(atPath: path)
    }
    
    public func createFile(contents data: Data?, attributes attr: [FileAttributeKey : Any]? = nil) -> Bool {
        
        return FileManager.default.createFile(atPath: path, contents: data, attributes: attributes)
    }
    
    var data: Data? {
        return FileManager.default.contents(atPath: path)
    }
}

//MARK: Access privileges
extension URL {
    
    /// Returns true if the path represents an actual file that is also writable by the current user.
    public var isWritable: Bool {
        return FileManager.default.isWritableFile(atPath: path)
    }
    
    /// Returns `true` if the current process has read privileges for the file at path.
    public var isReadable: Bool {
        return FileManager.default.isReadableFile(atPath: path)
    }
    
    /// Returns `true` if the current process has delete privileges for the file at path.
    public var isDeletable: Bool {
        return FileManager.default.isDeletableFile(atPath: path)
    }
}
