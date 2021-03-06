//
//  ProductDetailsPresenter.swift
//  LittleSearch
//
//  Created by Jade Silveira on 26/03/21.
//

import Foundation

protocol ProductDetailsPresenting: AnyObject {
    var viewController: ProductDetailsDisplaying? { get set }
    func presentLoading(shouldPresent: Bool)
    func present(productDetails: ItemDetailsSuccessResponse, installments: InstallmentsResponse?)
    func presentError()
}

final class ProductDetailsPresenter {
    weak var viewController: ProductDetailsDisplaying?
}

// MARK: - ProductDetailsPresenting
extension ProductDetailsPresenter: ProductDetailsPresenting {
    func presentLoading(shouldPresent: Bool) {
        viewController?.hideError()
        shouldPresent ? viewController?.startLoading() : viewController?.stopLoading()
    }
    
    func present(productDetails: ItemDetailsSuccessResponse, installments: InstallmentsResponse?) {
        let formattedSoldQuantity = FormatUtils.format(
            quantity: productDetails.soldQuantity,
            keyTextSingle: Strings.LocalizableKeys.soldQuantitySingle,
            keyTextMultiple: Strings.LocalizableKeys.soldQuantityMultiple
        )
        let formattedAvailableQuantity = FormatUtils.format(
            quantity: productDetails.availableQuantity,
            keyTextSingle: Strings.LocalizableKeys.availableQuantitySingle,
            keyTextMultiple: Strings.LocalizableKeys.availableQuantityMultiple
        )
        viewController?.setSoldQuantity(with: formattedSoldQuantity)
        viewController?.setTitle(with: productDetails.title)
        viewController?.setPictures(with: productDetails.pictures)
        viewController?.setPrice(productDetails.price)
        viewController?.setInstallments(InstallmentsUtils.format(installments: installments))
        viewController?.setAvailableQuantity(with: formattedAvailableQuantity)
        viewController?.setAttributes(with: productDetails.attributes)
        viewController?.hideError()
    }
    
    func presentError() {
        viewController?.displayError()
    }
}
