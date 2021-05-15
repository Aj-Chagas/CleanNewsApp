//
//  HomeViewSnapshotTest.swift
//  UITests
//
//  Created by Anderson Chagas on 05/05/21.
//

import Quick
import Nimble
import Nimble_Snapshots
import UIKit
@testable import UI

class HomeViewSnapshotTest: QuickSpec {
    
    override func spec() {
        
        it("has valid layout with table view and all of constraint correctly") {
            let frame = CGRect(x: 0, y: 0, width: 375, height: 620)
            let view = HomeView(frame: frame)
            view.tableView.backgroundColor = .green
            expect(view) == snapshot("HomeView")
        }
        
    }
    
}
