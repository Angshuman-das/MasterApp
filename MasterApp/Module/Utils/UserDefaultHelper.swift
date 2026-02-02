//
//  UserDefaultHelper.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import Foundation

protocol UserDefaultHelperProtocol {
    func getDataForKey(_ key: Constants.UserDefaultKeys) -> Any?
    func setDataForKey(_ key: Constants.UserDefaultKeys, val: Any)
}

class UserDefaultHelper: UserDefaultHelperProtocol {
    func getDataForKey(_ key: Constants.UserDefaultKeys) -> Any? {
        UserDefaults.standard.object(forKey: key.rawValue)
    }
    
    func setDataForKey(_ key: Constants.UserDefaultKeys, val: Any) {
        UserDefaults.standard.set(val, forKey: key.rawValue)
    }
}
