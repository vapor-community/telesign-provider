//
//  TelesignTypes.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/21/17.
//
//

public enum MessageType: String
{
    case OTP
    case ARN
    case MKT
}

public enum AccountLifecycleEvent: String
{
    case create
    case signIn = "sign-in"
    case transact
    case update
    case delete
}

public enum VoiceLanguage: String, Codable
{
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
    
    enum CodingKeys: String, CodingKey
    {
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
}

public enum VoiceLanguageOrUserInputResponse: Codable
{
    public func encode(to encoder: Encoder) throws {}
    
    case voice(VoiceLanguage)
    case userInput([String: String])
    
    public init(from decoder: Decoder) throws {
        let single = try decoder.singleValueContainer()
        
        if let _ = try? single.decode(String.self) {
            self = .voice(try VoiceLanguage(from: decoder))
            return
        }
        
        if let dict = try? single.decode([String: String].self) {
            self = .userInput(dict)
            return
        }

        throw DecodingError.typeMismatch(VoiceLanguageOrUserInputResponse.self, DecodingError.Context(codingPath: [], debugDescription: "`voice` was not present or `user_input` was not present"))
    }
}
