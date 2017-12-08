//
//  FileManager.swift
//  DataStorage
//
//  Created by Sergio Cirasa on 7/12/17.
//  Copyright © 2017 Sergio Cirasa. All rights reserved.
//

import UIKit

class DataStorage: NSObject {
    
    private static let rootFolderName = "app_v1"
    private static let lastUpdateKey = "lastUpdateKey_v1"
    
    // MARK: - Helper Methods
    private static func base64Encoded( _ str: String) -> String? {
        if let data = str.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    private static func base64Decoded( _ str: String) -> String? {
        if let data = Data(base64Encoded: str) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    private static func path(forKey key:String, inFolder folder: String? = nil) throws -> String {
        
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else{
            throw NSError(domain: "Invalid path", code: 0, userInfo: nil)
        }
        
        guard let filename =  base64Encoded(key) else{
            throw NSError(domain: "filename", code: 0, userInfo: nil)
        }
        
        let path = url.path + "/" + rootFolderName + "/" + ( folder ?? folder! + "/" )
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
            }catch{
                throw NSError(domain: "Invalid path", code: 0, userInfo: nil)
            }
        }
        
        return (path + "/" + filename)
    }
    
    public static func removeFile( forKey key:String, inFolder folder: String? = nil) throws {
        let path = try self.path(forKey: key, inFolder: folder)
        if FileManager.default.fileExists(atPath: path) {
            try FileManager.default.removeItem(atPath: path)
        }
        removeLastUpdateDate(forKey: key, inFolder: folder);
    }
    
    // MARK: - Save Methods
    public static func saveString(_ str: String, forKey key:String, inFolder folder: String? = nil) throws {
        let path = try self.path(forKey: key, inFolder: folder)
        try str.write(toFile: path, atomically: true, encoding: .utf8)
        saveLastUpdateDate(forKey: key, inFolder: folder)
    }
    
    public static func saveData(_ data: Data, forKey key:String, inFolder folder: String? = nil) throws {
        let path = try self.path(forKey: key, inFolder: folder)
        try data.write(to: URL(fileURLWithPath: path), options: .atomic)
        saveLastUpdateDate(forKey: key, inFolder: folder)
    }
    
    public static func saveObject(_  obj: Any, forKey key:String, inFolder folder: String? = nil) throws{
        let path = try self.path(forKey: key, inFolder: folder)
        if NSKeyedArchiver.archiveRootObject(obj, toFile: path) {
            saveLastUpdateDate(forKey: key, inFolder: folder)
        }else{
            throw NSError(domain: "The object can not be saved", code: 0, userInfo: nil)
        }
    }
    
    // MARK: - Load Methods
    public static func loadString( forKey key:String, inFolder folder: String? = nil) throws -> String? {
        let path = try self.path(forKey: key, inFolder: folder)
        return try String(contentsOfFile: path, encoding: .utf8)
    }
    
    public static func loadData( forKey key:String, inFolder folder: String? = nil ) throws -> Data?{
        let path = try self.path(forKey: key, inFolder: folder)
        return try Data(contentsOf: URL(fileURLWithPath: path))
    }
    
    public static func loadObject( forKey key:String, inFolder folder: String? = nil) throws -> Any?{
        let path = try self.path(forKey: key, inFolder: folder)
        return NSKeyedUnarchiver.unarchiveObject(withFile: path)
    }
    
    // MARK: - Timestamp Methods
    public static func timeIntervalSinceTheLastUpdate(forKey key:String, inFolder folder: String? = nil) -> TimeInterval{
        if let date = lastUpdateDate(forKey: key, inFolder: folder) {
            return date.timeIntervalSinceNow * -1
        }
        return -1
    }
    
    public static func lastUpdateDate(forKey key:String, inFolder folder: String? = nil) -> Date?{
        if let mainDic = UserDefaults.standard.object(forKey: rootFolderName) as? Dictionary<String, Date> {
            let dateKey = folder != nil ? (folder!+key) : key
            return mainDic[dateKey]
        }
        return nil
    }
    
    private static func saveLastUpdateDate(forKey key:String, inFolder folder: String? = nil){
        
        var mainDic = (UserDefaults.standard.object(forKey: rootFolderName) as? Dictionary<String, Date>) ?? Dictionary<String, Date>()
        let dateKey = folder != nil ? (folder!+key) : key
        mainDic[dateKey] = Date()
        UserDefaults.standard.set(mainDic, forKey: rootFolderName)
        UserDefaults.standard.synchronize()
    }
    
    private static func removeLastUpdateDate(forKey key:String, inFolder folder: String? = nil){
        var mainDic = (UserDefaults.standard.object(forKey: rootFolderName) as? Dictionary<String, Date>) ?? Dictionary<String, Date>()
        let dateKey = folder != nil ? (folder!+key) : key
        mainDic.removeValue(forKey: dateKey)
        UserDefaults.standard.set(mainDic, forKey: rootFolderName)
        UserDefaults.standard.synchronize()
    }
}

