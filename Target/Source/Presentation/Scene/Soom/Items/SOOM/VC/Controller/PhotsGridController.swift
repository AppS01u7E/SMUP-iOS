//
//  PhotsGridController.swift
//  SMUP
//
//  Created by Sunghun Kim on 2022/01/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import LBTATools

protocol MyCollectionViewLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat
}

class MyLayout: UICollectionViewLayout {
    weak var delegate: MyCollectionViewLayoutDelegate?

    fileprivate var numberOfColumns: Int = 2
    fileprivate var cellPadding: CGFloat = 6.0
    fileprivate var cache: [UICollectionViewLayoutAttributes] = []
    fileprivate var contentHeight: CGFloat = 0.0

    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0.0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    // 바로 다음에 위치할 cell의 위치를 구하기 위해서 xOffset, yOffset 계산
    override func prepare() {
        super.prepare()

        // cache에 이미 layout 정보가 있으면 그것 그대로 사용, 없으면 layout 다시 계산
        guard cache.isEmpty, let collectionView = collectionView else { return }

        // xOffset 계산
        let columnWidth: CGFloat = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            let offset = CGFloat(column) * columnWidth
            xOffset += [offset]
        }

        // yOffset 계산
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)

            let imageHeight = delegate?.collectionView(collectionView, heightForImageAtIndexPath: indexPath) ?? 0
            let height = cellPadding + imageHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            // cache 저장
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)

            // 새로 계산된 항목의 프레임을 설명하도록 확장
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height

            // 다음 항목이 다음 열에 배치되도록 설정
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }

    // rect에 따른 layoutAttributes를 얻는 메서드 재정의
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { rect.intersects($0.frame) }
    }

    // indexPath에 따른 layoutAttribute를 얻는 메서드 재정의
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }

}


class MyCell: UICollectionViewCell {

    static var id: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
    var photoModel: PhotoModel? {
        didSet { bind() }
    }

    lazy var containerView: UIView = {
        let view = UIView()

        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupView() {

        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        containerView.layer.cornerRadius = 10
    }

    private func bind() {
        containerView.backgroundColor = photoModel?.color
    }
}


class PhotosGridController: UIViewController {

    var collectionView: UICollectionView!
    var dataSource: [PhotoModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDataSource()

        configure()
    }

    private func configure() {

        let collectionViewLayout = MyLayout()
        collectionViewLayout.delegate = self
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        collectionView.isScrollEnabled = false

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: MyCell.id)
    }

    
    private func setupDataSource() {
        dataSource = PhotoModel.getMock()
    }
}
    
extension PhotosGridController: MyCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        return dataSource[indexPath.item].contentHeightSize
    }
}
extension PhotosGridController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCell.id, for: indexPath)
        if let cell = cell as? MyCell {
            cell.photoModel = dataSource[indexPath.item]
            cell.layer.cornerRadius = 10
        }
        return cell
    }
}

