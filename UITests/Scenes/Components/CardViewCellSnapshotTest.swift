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

class CardViewCellSnapshotTest: QuickSpec {
    
    override func spec() {
        
        it("has valid snapshot") {
            let view = CardViewCell()
            view.frame = iphone8Frame()
            view.title.text = "News"
            view.subTitle.text = "subtitle"
            expect(view) == snapshot()
        }
        
    }
    
}
