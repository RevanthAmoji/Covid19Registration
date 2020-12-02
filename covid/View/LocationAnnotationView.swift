//
//  LocationAnnotationView.swift
//  covid
//
//  Created by venkata baisani on 30/11/20.
//

import Foundation
import UIKit
import MapKit



final class LocationAnnotationView: MKAnnotationView {

    // MARK: Initialization

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        frame = CGRect(x: 0, y: 0, width: 40, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)

        canShowCallout = true
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup

    private func setupUI() {
        backgroundColor = .clear

//        let view = MapPinView()
//        addSubview(view)

       // view.frame = bounds
    }
}
