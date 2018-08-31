//
//  NSErrorExtension.swift
//  dropoff
//
//  Created by Sergio Cirasa on 4/1/18.
//  Copyright © 2018 Sergio Cirasa. All rights reserved.
//

import Foundation
import UIKit

extension NSError {
    
    convenience init(localizedDescription text: String) {
        self.init(domain: "MFDemoErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: text])
    }

}

