//
//  MockImageService.swift
//  BRTakeHomeTests
//
//  Created by Tanner Perry on 2/10/22.
//

import Foundation
import UIKit

@testable import BRTakeHome

class MockImageService : ImageServiceProtocol {
    var getImageWithNameCalled = false
    var getImageWithNameCalledPassedWithName = ""
    func getImage(withName: String) -> UIImage? {
        getImageWithNameCalled = true
        getImageWithNameCalledPassedWithName = withName
        
        return nil
    }

    
    func cache(image: UIImage, withName: String) {
        
    }
    
    
}
