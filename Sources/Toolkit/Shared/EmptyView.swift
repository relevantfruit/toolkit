import SnapKit
import UIKit

public protocol EmptyViewDatasource {
    var image: UIImage? { get }
    var title: String { get }
    var description: String { get }
}

public final class EmptyView: UIView {
    
    // MARK: - Properties
    private lazy var emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { $0.height.equalTo(defaultImageSize) }
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = .create(textColor: defaultTitleColor, font: defaultFont)
    
    private lazy var descriptionLabel: UILabel = .create(textColor: defaultDescriptionColor, font: defaultFont)
    
    private lazy var stackView: UIStackView = .create(arrangedSubViews: [emptyImageView, titleLabel, descriptionLabel], spacing: 20.0)
    
    private var defaultFont: UIFont
    private var defaultImageSize: Int = 100
    private var defaultTitleColor: UIColor = .black
    private var defaultDescriptionColor: UIColor = .white
    
    // MARK: - Initialization
    init(with font: UIFont, imageSize: Int = 100, titleColor: UIColor = .black, descriptionColor: UIColor = .white) {
        defaultFont = font
        defaultImageSize = 100
        defaultTitleColor = titleColor
        defaultDescriptionColor = descriptionColor
        super.init(frame: .zero)
        
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
            make.center.equalToSuperview()
        }
        
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Populate UI
public extension EmptyView {
    func populate(with datasource: EmptyViewDatasource) {
        emptyImageView.image = datasource.image
        emptyImageView.isHidden = datasource.image == nil
        
        titleLabel.text = datasource.title
        titleLabel.isHidden = datasource.title.isEmpty
        
        descriptionLabel.text = datasource.description
        descriptionLabel.isHidden = datasource.description.isEmpty
    }
}
