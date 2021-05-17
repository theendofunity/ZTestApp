//
//  StringConverter.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 18.05.2021.
//

import Foundation

func htmlAttributeString(from string: String) -> NSAttributedString? {
    let htmlData = NSString(string: string).data(using: String.Encoding.unicode.rawValue)
    let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
            NSAttributedString.DocumentType.html]
    let attributedString = try? NSMutableAttributedString(data: htmlData ?? Data(),
                                                              options: options,
                                                              documentAttributes: nil)
    return attributedString
}
