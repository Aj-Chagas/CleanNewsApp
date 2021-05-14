//
//  CardViewSnapshotTest.swift
//  UITests
//
//  Created by Anderson Chagas on 12/05/21.
//

import Quick
import Nimble
import Nimble_Snapshots
import UIKit
@testable import UI

class CardViewSnapshotTest: QuickSpec {
    
    override func spec() {
        
        it("has valid snapshot") {
            let frame = CGRect(x: 0, y: 0, width: 375, height: 620)
            let view = CardViewCell()
            view.frame = frame
            expect(view) == snapshot()
            
        }
        
    }
    
}
