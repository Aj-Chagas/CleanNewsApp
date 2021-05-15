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
            let frame = CGRect(x: 0, y: 0, width: 375, height: 70)
            let view = HeaderView(frame: frame)
            view.dateLabel.text = "sexta-feira, 14 de maio"
            expect(view) == snapshot()
        }
        
    }
    
}
