//
//  ObjectMapperTransformer.swift
//  News Client
//
//  Created by Duy Cao on 12/3/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import Foundation
import ObjectMapper
public class DateFormatTransform: TransformType {
    public func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString = value as? String {
            return self.dateFormat.date(from: dateString)
        }
        return nil
    }
    
    public func transformToJSON(_ value: Date?) -> String? {
        if value != nil {
            return self.dateFormat.string(from: value! as Date)
        }
        return nil
    }
    
    public typealias Object = Date
    public typealias JSON = String
    
    
    var dateFormat = DateFormatter()
//    dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = DateFormatter()
        self.dateFormat.dateFormat = dateFormat
    }
}
