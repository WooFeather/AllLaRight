//
//  Button+.swift
//  AllLaRight
//
//  Created by 조우현 on 3/11/25.
//

import UIKit

extension UIButton.Configuration {
    static func moreButtonStyle() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 10)
        configuration.image = UIImage(systemName: "chevron.right")
        configuration.preferredSymbolConfigurationForImage = imageConfig
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = ALRFont.headline.font
            return outgoing
        }
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 1.0
        return configuration
    }
}
