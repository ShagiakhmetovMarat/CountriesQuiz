//
//  StorageManager.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 12.12.2022.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let settingKey = "setting"
    private let languageKey = "appLanguage"
    
    private init() {}
    
    func saveSetting(setting: Setting) {
        guard let data = try? JSONEncoder().encode(setting) else { return }
        userDefaults.set(data, forKey: settingKey)
    }
    
    func fetchSetting() -> Setting {
        guard let data = userDefaults.object(forKey: settingKey) as? Data else { return Setting.getSettingDefault(.english) }
        guard let setting = try? JSONDecoder().decode(Setting.self, from: data) else { return Setting.getSettingDefault(.english) }
        return setting
    }
    
    func saveLanguage(language: String) {
        userDefaults.set(language, forKey: languageKey)
    }
    
    func loadLanguage() {
        if let language = userDefaults.string(forKey: languageKey) {
            Bundle.setLanguage(language)
        } else {
            Bundle.setLanguage("en")
        }
    }
    
    func fetchLanguage() -> String {
        guard let language = userDefaults.string(forKey: languageKey) else { return "en" }
        return language
    }
    
    func addFavorite(favorite: Favorites, key: String) {
        var favorites = fetchFavorites(key: key)
        favorites.append(favorite)
        guard let data = try? JSONEncoder().encode(favorites) else { return }
        userDefaults.set(data, forKey: key)
    }
    
    func deleteFavorite(favorite: Int, key: String) {
        var favorites = fetchFavorites(key: key)
        favorites.remove(at: favorite)
        guard let data = try? JSONEncoder().encode(favorites) else { return }
        userDefaults.set(data, forKey: key)
    }
    
    func fetchFavorites(key: String) -> [Favorites] {
        guard let data = userDefaults.object(forKey: key) as? Data else { return [] }
        guard let favorites = try? JSONDecoder().decode([Favorites].self, from: data) else { return [] }
        return favorites
    }
}
