//
//  Sequence.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 26.05.2022.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
