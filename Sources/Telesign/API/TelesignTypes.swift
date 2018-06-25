//
//  TelesignTypes.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/21/17.
//
//

public enum MessageType: String {
    /// One time passwords.
    case OTP
    /// Alerts, reminders, and notifications.
    case ARN
    /// Marketing traffic.
    case MKT
}

public enum AccountLifecycleEvent: String {
    /// For the creation of a new account.
    case create
    /// For when an end user signs in to their account.
    case signIn = "sign-in"
    /// For when an end user completes a transaction within their account.
    case transact
    /// For when an update is performed, such as an update of account information or similar.
    case update
    /// For when an account is deleted.
    case delete
}

public enum VoiceLanguage: String, Codable {
    case chineseHongKong = "f-zh-HK"
    case chineseMandarin = "f-zh-CN"
    case chineseTaiwan = "f-zh-TW"
    case danish = "f-da-DK"
    case dutch = "f-nl-NL"
    case englishAustralian = "f-en-AU"
    case englishUK = "f-en-GB"
    case englishUS = "f-en-US"
    case englishCanadian = "f-en-CA"
    case englishIndia = "f-en-IN"
    case finnish = "f-fi-FI"
    case french = "f-fr-FR"
    case frenchCanadian = "f-fr-CA"
    case german = "f-de-DE"
    case italian = "f-it-IT"
    case japanese = "f-ja-JP"
    case korean = "f-ko-KR"
    case norweigan = "f-nb-NO"
    case portugueseBrazil = "f-pt-BR"
    case portugueseEurope = "f-pt-PT"
    case russian = "f-ru-RU"
    case spanish = "f-es-MX"
    case spanishSpain = "f-es-ES"
    case spanishCatalan = "f-ca-ES"
    case swedish = "f-sv-SE"
}

public enum VoiceLanguageOrUserInputResponse: Codable {
    public func encode(to encoder: Encoder) throws {}
    
    case voice(VoiceLanguage)
    case userInputAndCallerId([String: String])
    
    public init(from decoder: Decoder) throws {
        let single = try decoder.singleValueContainer()
        
        if let _ = try? single.decode(String.self) {
            self = .voice(try VoiceLanguage(from: decoder))
            return
        }
        
        if let dict = try? single.decode([String: String].self) {
            self = .userInputAndCallerId(dict)
            return
        }

        throw DecodingError.typeMismatch(VoiceLanguageOrUserInputResponse.self, DecodingError.Context(codingPath: [], debugDescription: "`voice` was not present or `user_input` was not present"))
    }
}
