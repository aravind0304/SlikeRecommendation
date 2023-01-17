
public enum AppEnvironment: String, CaseIterable {
    case dev = "dev"
    case production = "prod"
    public var name: String {
        switch self {
        case .dev:
            return "Development"
        case .production:
            return "Production"
        }
    }
}


public enum Environment {
    // MARK: Handle Environment Changes
    
    public static let current: APIProtocol = {
#if NON_PROD
        switch getCurrentEnvironment() {
        case .dev:
            return BaseURLDev()
        case .production:
            return BaseURLProd()
        }
#else
        // Always return Prod config for App-Store Builds
        return BaseURLProd()
#endif
    }()
    
    
    
    public static func getCurrentEnvironment() -> AppEnvironment {
        return .production
    }
}

