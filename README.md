# CryptoStocks App 
<br />
    <p align="center">
        iOS pet project app for browsing cryptocurrencies (50 items) 
    </p>
</p>
<p align="center">
<img src= "Screenshots/AllCrypto_portrait.png" width="250">
<img src= "Screenshots/Favorites_portrait.png" width="250">
<img src= "Screenshots/Search_portrait.png" width="250">
</p>
<p align="center">
<img src= "Screenshots/Graphic_6Month_portrait.png" width="250">
<img src= "Screenshots/Graphic_1Month_portrait.png" width="250">
<img src= "Screenshots/Detaied_Button_portrait.png" width="250">
</p>

## Requierments
- IPhone 11+
- iOS 14.0+

## About
- UIKit 
- Programmatically designed UI with NSLayoutConstraints
- MVP architecture
- SPM dependencies: Charts, KingFisher
- Crypto list's API: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=50
- Prices' API: https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=600&interval=daily
(where "bitcoin" - id of cryptocurrency)
- FavoritesService: NSNotificationCenter, FileManager, UserDefaults - optional.
</p>
<p align="center">
        Code reviewers: tauypaldiyev, justadlet.
    </p>
