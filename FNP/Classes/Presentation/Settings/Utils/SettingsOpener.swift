//
//  SettingsOpener.swift
//  FNP
//
//  Created by Andrey Chernyshev on 12.07.2021.
//

import UIKit
import RxSwift

final class SettingsOpener {
    enum Screen {
        case mode
    }
    
    private lazy var disposeBag = DisposeBag()
    
    func open(screen: Screen, from: UIViewController) {
        let view = makeView(for: screen)
        let vc = makeVC(with: view)

        view.didNextTapped = { _ in
            vc.dismiss(animated: true)
        }

        from.present(vc, animated: true)
    }
}

// MARK: Private
private extension SettingsOpener {
    func makeVC(with view: UIView) -> UIViewController {
        let vc = UIViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.view.backgroundColor = Appearance.backgroundColor
        vc.view.addSubview(view)
        
        let closeButton = UIButton()
        closeButton.frame.origin = CGPoint(x: 16.scale, y: 64.scale)
        closeButton.frame.size = CGSize(width: 24.scale, height: 24.scale)
        closeButton.setImage(UIImage(named: "Settings.Close"), for: .normal)
        vc.view.addSubview(closeButton)
        
        closeButton.rx.tap
            .subscribe(onNext: {
                vc.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        return vc
    }
    
    func makeView(for screen: Screen) -> OSlideView {
        let view: OSlideView

        switch screen {
        case .mode:
            view = OSlideModesView(step: .modes)
        }

        view.frame = UIScreen.main.bounds

        return view
    }
}
