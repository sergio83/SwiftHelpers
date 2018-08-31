//
//  FileManager.swift
//  DataStorage
//
//  Created by Sergio Cirasa on 7/12/17.
//  Copyright © 2017 Sergio Cirasa. All rights reserved.
//

import UIKit

@objc public class DataStorage: NSObject {
    
    public static var rootFolderName = "app_v1"
    
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
        
        let path = url.path + "/" + rootFolderName + ( folder == nil ?  "/" : folder! + "/")
        
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

    public static func save<T>(_  obj: T, forKey key:String, inFolder folder: String? = nil) throws where T : Codable{
        let path = try self.path(forKey: key, inFolder: folder)
        let archiver = NSKeyedArchiver()
        try archiver.encodeEncodable(obj, forKey: NSKeyedArchiveRootObjectKey)
        try archiver.encodedData.write(to: URL(fileURLWithPath: path))
        saveLastUpdateDate(forKey: key, inFolder: folder)
    }
    
    public static func getKeys( inFolder folder: String?) throws -> [String] {
        let path1 = try path(forKey: "", inFolder: folder)
        var array = [String]()
        let directoryContents = try FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: path1), includingPropertiesForKeys: [.isDirectoryKey])
        let filesOnly = directoryContents.filter { (url) -> Bool in
            do {
                let resourceValues = try url.resourceValues(forKeys: [.isDirectoryKey])
                return !resourceValues.isDirectory!
            } catch { return false }
        }
        
        for url in filesOnly {
            if let str = base64Decoded(url.lastPathComponent){
                array.append(str)
            }
        }
        
        return array
    }
    
    // MARK: - Load Methods
    public static func loadString( forKey key:String, inFolder folder: String? = nil) -> String? {
        do{
            let path = try self.path(forKey: key, inFolder: folder)
            return try String(contentsOfFile: path, encoding: .utf8)
        }catch{
            return nil;
        }
    }
    
    public static func loadData( forKey key:String, inFolder folder: String? = nil ) -> Data?{
        do{
            let path = try self.path(forKey: key, inFolder: folder)
            if FileManager.default.fileExists(atPath: path) {
                return try Data(contentsOf: URL(fileURLWithPath: path))
            }
            return nil
        }catch{
            return nil;
        }
    }
    
    public static func loadObject( forKey key:String, inFolder folder: String? = nil) -> Any?{
        do{
            let path = try self.path(forKey: key, inFolder: folder)
            if FileManager.default.fileExists(atPath: path) {
                return NSKeyedUnarchiver.unarchiveObject(withFile: path)
            }
            return nil
        }catch{
            return nil;
        }
    }
    
    public static func load<T>(_ type: T.Type,  forKey key:String, inFolder folder: String? = nil) -> T?  where T : Decodable{
        do{
            let path = try self.path(forKey: key, inFolder: folder)
            if FileManager.default.fileExists(atPath: path) {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                let someone = try unarchiver.decodeTopLevelDecodable(type, forKey: NSKeyedArchiveRootObjectKey)
                unarchiver.finishDecoding()
                return someone
            }
        }catch{}
        return nil
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


