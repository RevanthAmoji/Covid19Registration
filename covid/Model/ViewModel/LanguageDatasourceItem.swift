//
//  LanguageDatasourceItem.swift
//  covid
//
//  Created by venkata baisani on 20/11/20.
//

import Foundation

protocol DropdownDatasourceItem {
    var title: String? { get set }
}
struct LanguageDatasourceItem: DropdownDatasourceItem {
    var title: String?
    var selected: Bool = false
}

protocol DropdownDatasource {
    var selectedIndex: Int? { get set }
    func count() -> Int
    func itemAtIndex(index: Int) -> DropdownDatasourceItem
    func selectedItem() -> DropdownDatasourceItem?
}

class SutherlandDropdownDatasource<ItemType: DropdownDatasourceItem>: NSObject, DropdownDatasource {
    
    var selectedIndex: Int?
    var items = [ItemType]()


    func count() -> Int {
        items.count
    }
    func itemAtIndex(index: Int) -> DropdownDatasourceItem {
        items[index]
    }

    func selectedItem() -> DropdownDatasourceItem? {
        guard let selectedIndex = selectedIndex else {
            return nil
        }
        return itemAtIndex(index: selectedIndex)
    }
}
