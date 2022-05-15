//
//  MockCategoriesProvider.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 15.05.2022.
//

import Foundation

class MockCategoriesProvider {
    func createMockCategories() -> [CardsCategory] {
        return [
            CardsCategory(categoryKey: "Растения", categoryColor: nil, categoryImage: nil),
            CardsCategory(categoryKey: "Животные", categoryColor: nil, categoryImage: nil),
            CardsCategory(categoryKey: "Путешествия", categoryColor: nil, categoryImage: nil),
            CardsCategory(categoryKey: "Еда", categoryColor: nil, categoryImage: nil),
            CardsCategory(categoryKey: "Разное", categoryColor: nil, categoryImage: nil),
//            CardsCategory(categoryKey: "Работа", categoryColor: nil, categoryImage: nil),
//            CardsCategory(categoryKey: "Офис", categoryColor: nil, categoryImage: nil),
//            CardsCategory(categoryKey: "Финансы", categoryColor: nil, categoryImage: nil),
//            CardsCategory(categoryKey: "Компьютеры", categoryColor: nil, categoryImage: nil),
        ]
    }
}
