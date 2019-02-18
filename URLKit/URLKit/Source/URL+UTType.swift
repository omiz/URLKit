//
//  URL+UTType.swift
//  URLKit
//
//  Created by Omar Allaham on 1/23/19.
//  Copyright © 2019 Martian Bears. All rights reserved.
//

// https://developer.apple.com/documentation/mobilecoreservices/uttype
// https://developer.apple.com/library/archive/documentation/Miscellaneous/Reference/UTIRef/Articles/System-DeclaredUniformTypeIdentifiers.html

/**
 
    Example XML Type Declaration

    Appearing below is an XML excerpt from a bundle Info.plist file which
    declares the public type "public.jpeg":
 
        <key>UTExportedTypeDeclarations</key>
        <array>
            <dict>
                <key>UTTypeIdentifier</key>
                <string>public.jpeg</string>
                <key>UTTypeDescription</key>
                <string>JPEG image</string>
                <key>UTTypeIconFile</key>
                <string>public.jpeg.icns</string>
                <key>UTTypeConformsTo</key>
                <array>
                    <string>public.image</string>
                </array>
                <key>UTTypeTagSpecification</key>
                <dict>
                    <key>com.apple.ostype</key>
                    <string>JPEG</string>
                    <key>public.filename-extension</key>
                    <array>
                        <string>jpeg</string>
                        <string>jpg</string>
                    </array>
                    <key>public.mime-type</key>
                    <string>image/jpeg</string>
                </dict>
            </dict>
        </array>
 
 **/

import Foundation
import MobileCoreServices

extension URL {
    
    public var uttypeIdentification: UTTypeIdentification {
        return UTTypeIdentification(pathExtension)
    }
}



public struct UTTypeIdentification {
    
    public let pathExtension: String
    
    init(_ pathExtension: String) {
        self.pathExtension = pathExtension
    }
    
    public var typeDeclaration: [CFString: Any] {
        
        let pathExtension = self.pathExtension as CFString
        
        let identifier = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                               pathExtension, nil)
        
        guard let UTI = identifier?.takeRetainedValue() else { return [:] }
        
        guard let declaration = UTTypeCopyDeclaration(UTI)?.takeRetainedValue() else { return [:] }
        
        guard let dictionary = declaration as? [CFString: Any] else { return [:] }
        
        return dictionary
    }
    
    public var typeConformsTo: [String] {
        
        let result = typeDeclaration[kUTTypeConformsToKey] as? [String]
        
        return result ?? []
    }
    
    public var typeDescription: String {
        
        let result = typeDeclaration[kUTTypeDescriptionKey] as? String
        
        return result ?? ""
    }
    
    public var typeIdentifier: String {
        
        let result = typeDeclaration[kUTTypeIdentifierKey] as? String
        
        return result ?? ""
    }
    
    public var TypeTagSpecification: [CFString: Any] {
        
        let result = typeDeclaration[kUTTypeTagSpecificationKey] as? NSDictionary
        
        return result as? [CFString: Any] ?? [:]
    }
    
    public var MIMETypes: [String] {
        
        let result = TypeTagSpecification[kUTTagClassMIMEType] as? [String]
        
        return result ?? []
    }
    
    public var mimeType: String {
        return MIMETypes.first ?? "application/octet-stream"
    }
    
    public func typeConforms(to UTType: CFString) -> Bool {
        
        let identifier = typeIdentifier as CFString
        
        return UTTypeConformsTo(identifier, UTType)
    }
    
    public func typeEqual(to UTType: CFString) -> Bool {
        
        let identifier = typeIdentifier as CFString
        
        return UTTypeEqual(identifier, UTType)
    }
}
