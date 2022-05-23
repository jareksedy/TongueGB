//
//  MockCategoriesProvider.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 15.05.2022.
//

import Foundation

class MockCategoriesProvider {
    func createMockCategories() -> [CategoryFirebase] {
        return [
            CategoryFirebase(categoryName: "Растения"),
            CategoryFirebase(categoryName: "Животные"),
            CategoryFirebase(categoryName: "Путешествия"),
            CategoryFirebase(categoryName: "Еда"),
            CategoryFirebase(categoryName: "Разное")
//            CategoryFirebase(categoryName: "Работа"),
//            CategoryFirebase(categoryName: "Офис"),
//            CategoryFirebase(categoryName: "Финансы"),
//            CategoryFirebase(categoryName: "Компьютеры"),
        ]
    }
}
