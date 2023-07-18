//
//  AppDebugger.swift
//

import Foundation



@objc public class AppDebugger: NSObject
{
    public enum DebugType: String, CaseIterable
    {
        
        case General = "--- General Debugging ---"
        
    }
    
    
    static let MEASURE_ALAMOFIRE_REQUEST:Bool = false
    
#if RELEASE
    private var debugTypes:Set<DebugType> = Set<DebugType>()
#else
    
    private var debugTypes:Set<DebugType> = Set<DebugType>([.General])
#endif
    
    private var timeStamp: TimeInterval = Date().timeIntervalSince1970
    
    
    
    
    // MARK: -
    // MARK: - SingleTone
    @objc public static let shared: AppDebugger = AppDebugger()
    override private init() {
        super.init()
    }
    
    
    // MARK: -
    // MARK: - Publics
    
    public func print(type: DebugType, message: String?)
    {
        self.print(message, type: type)
    }
    public func print(_ message: String?, type: DebugType, filename: String = #file)
    {
        guard let message = message,
              !message.isEmpty,
              self.debugTypes.contains(type) == true
        else { return }
        
        let msg = self.getFullMessage(message, type: type)
        Log.msg(msg,filename: filename)
        
        
    }
    public func printErrorMessage(_ message: String?, type: DebugType, filename: String = #file)
    {
        guard let message = message,
              !message.isEmpty,
              self.debugTypes.contains(type) == true
        else { return }
        
        let msg = self.getFullMessage(message, type: type)
        Log.e(msg, filename: filename)
        
    }
    public func printSuccessMessage(type: DebugType, message: String?, filename: String = #file)
    {
        guard let message = message,
              !message.isEmpty,
              self.debugTypes.contains(type) == true
        else { return }
        
        let msg = self.getFullMessage(message, type: type)
        Log.msg(msg, filename: filename)
    }
    public func printSuccessMessage(_ message: String?, type: DebugType)
    {
        guard let message = message,
              !message.isEmpty,
              self.debugTypes.contains(type) == true
        else { return }
        
        let msg = self.getFullMessage(message, type: type)
        Log.msg(msg)
        
        
    }
    public func printWarningMessage(_ message: String?, type: DebugType,  filename: String = #file)
    {
        guard let message = message,
              !message.isEmpty,
              self.debugTypes.contains(type) == true
        else { return }
        
        let msg = self.getFullMessage(message, type: type)
        Log.w(msg, filename: filename)
        
    }
    public func printError(_ error: NSError?, type: DebugType)
    {
        guard let error = error,
              self.debugTypes.contains(type) == true
        else { return }
        Log.e(error)
        
    }
    public func printError(_ error: Error?, type: DebugType,  filename: String = #file)
    {
        guard let error = error,
              self.debugTypes.contains(type) == true
        else { return }
        Log.e(error, filename: filename)
        
    }
}


// MARK: -
// MARK: - Privates
fileprivate extension AppDebugger
{
    private func getFullMessage(_ message: String, type: DebugType) -> String
    {
        let timeStamp: String = self.getTimeStamp()
        
        let prefix: String = "TFS:[\(timeStamp)] <<< \(type.rawValue) >>>"
        let lines = message.components(separatedBy: "\n")
        var newMessage = ""
        lines.forEach { line in
            if line.isEmpty
            {
                newMessage = "\(newMessage)\n"
            }
            else
            {
                if newMessage.isEmpty
                {
                    newMessage = "\(prefix) \(line)"
                }
                else
                {
                    newMessage = "\(newMessage)\n\(prefix) \(line)"
                }
            }
        }
        
        
        let fullMessage: String = "\(newMessage)"
        
        return fullMessage
    }
    
    private func getTimeStamp() -> String
    {
        let currentTimeStamp = Date().timeIntervalSince1970
        let timePassed = currentTimeStamp - self.timeStamp
        let timePassedStr = timePassed.string(maximumFractionDigits: 3)
        
        
        return timePassedStr
    }
}


// MARK: -
// MARK: - ObjC exposed
@objc public extension AppDebugger
{
    
    @objc enum DebugType_Objc: Int, CaseIterable {
        case general_Objc
        
        
        var description: DebugType? {
            
            switch self {
            case .general_Objc:
                return AppDebugger.DebugType.General
                
            default:
                return nil
                
            }
        }
    }
    
    @objc func print(_ message: String?, type: DebugType_Objc)
    {
        if let type = type.description
        {
            self.print(message, type: type)
        }
    }
    
    
    @objc func printErrorMessage(_ message: String?, type: DebugType_Objc)
    {
        if let type = type.description
        {
            self.printErrorMessage(message, type: type)
        }
    }
    @objc func printSuccessMessage(_ message: String?, type: DebugType_Objc)
    {
        if let type = type.description
        {
            self.printSuccessMessage(message, type: type)
        }
    }
    @objc func printWarningMessage(_ message: String?, type: DebugType_Objc)
    {
        if let type = type.description
        {
            self.printWarningMessage(message, type: type)
        }
    }
    @objc func printError(_ error: NSError?, type: DebugType_Objc)
    {
        if let type = type.description
        {
            self.printError(error, type: type)
        }
    }
}
