//
//  HeaderViewSnapshotTest.swift
//  UITests
//
//  Created by Anderson Chagas on 14/05/21.
//

import Quick
import Nimble
import Nimble_Snapshots
import UIKit
@testable import UI

class HeaderViewSnapshotTest: QuickSpec {
    
    override func spec() {
        
        it("has valid snapshot") {
            let view = HeaderView(frame: iphone8Frame())
            expect(view) == snapshot()
        }
        
    }
    
}
