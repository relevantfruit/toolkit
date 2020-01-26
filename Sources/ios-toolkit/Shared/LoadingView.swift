import SnapKit
import Lottie
import SwifterSwift
import UIKit

public final class LoadingView: UIView {
    
    // MARK: - Properties
    private(set) lazy var animationsView: AnimationView = {
        let view = AnimationView(name: "loading-animation")
        view.contentMode = .scaleAspectFit
        view.loopMode = .loop
        return view
    }()
    
    private lazy var loadingSize: CGFloat = UIScreen.main.bounds.width / 1.5
    
    // MARK: - Initialization
    public init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.init(hex: 0x1E2336, transparency: 0.5)
        
        addSubview(animationsView)
        
        animationsView.snp.makeConstraints { make in
            make.width.equalTo(loadingSize)
            make.height.equalTo(loadingSize)
            make.center.equalTo(self)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public protocol LoadingHandler {
    var loadingView: LoadingView { get }
    
    func showLoading()
    func hideLoading()
}

public extension LoadingHandler where Self: UIView {
    func showLoading() {
        loadingView.alpha = 0
        addSubview(loadingView)
        loadingView.snp.makeConstraints { $0.edges.equalTo(self) }
        UIView.animate(withDuration: 0.3, animations:  {
            self.loadingView.animationsView.play()
            self.loadingView.alpha = 1
        })
    }
    
    func hideLoading() {
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView.alpha = 0
            self.loadingView.animationsView.stop()
        }, completion: { _ in
            self.loadingView.removeFromSuperview()
        })
    }
}

public extension LoadingHandler where Self: UIViewController {
    func showLoading() {
        loadingView.alpha = 0
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView.alpha = 1
            self.loadingView.animationsView.play()
        })
    }
    
    func hideLoading() {
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView.alpha = 0
            self.loadingView.animationsView.stop()
        }, completion: { _ in
            self.loadingView.removeFromSuperview()
        })
    }
}
