//
//  ViewController.swift
//  FilterExample
//
//  Created by 이광용 on 2018. 2. 6..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    private var filterParameterValues: [String: AnyObject] = [kCIInputImageKey: CIImage(image: #imageLiteral(resourceName: "example"))!]
    
    let exclusions = ["CIQRCodeGenerator",
                      "CIPDF417BarcodeGenerator",
                      "CICode128BarcodeGenerator",
                      "CIAztecCodeGenerator",
                      "CIColorCubeWithColorSpace",
                      "CIColorCube",
                      "CIAffineTransform",
                      "CIAffineClamp",
                      "CIAffineTile",
                      "CICrop"] // to do: fix CICrop!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        CustomFiltersVendor.registerFilter()
        print(supportedFilterNamesInCategory(category: CATEGORYCUSTOMFILTERS))
        guard let filter = CIFilter(name: RGBChannelBrightnessAndContrast.reuseIdentifier) else {return}
        
        print(filter.inputKeys)
        
        fixFilterParameterValues(filter: filter)
        print(filterParameterValues)
        
        
        for (key, value) in self.filterParameterValues where filter.inputKeys.contains(key) {
            filter.setValue(value, forKey: key)
        }
        filter.setValue(CIImage(image: #imageLiteral(resourceName: "example")), forKey: "inputImage")
        
        if let image = filter.outputImage {
            imageView.image = UIImage(ciImage: image)
        }

    }
    
    func  fixFilterParameterValues(filter: CIFilter) {
        let attributes = filter.attributes
        for inputKey in filter.inputKeys {
            if let attribute = attributes[inputKey] as? [String: AnyObject] {
                if let className = attribute[kCIAttributeClass] as? String, className == "CIImage" && filterParameterValues[inputKey] == nil
                {
                    filterParameterValues[inputKey] = CIImage(image: #imageLiteral(resourceName: "example"))
                }
                
                // ensure previous values don't exceed kCIAttributeSliderMax for this filter
                if let maxValue = attribute[kCIAttributeSliderMax] as? Float,
                    let filterParameterValue = filterParameterValues[inputKey] as? Float, filterParameterValue > maxValue
                {
                    filterParameterValues[inputKey] = maxValue as AnyObject
                }
                
                // ensure vector is correct length
                if let defaultVector = attribute[kCIAttributeDefault] as? CIVector,
                    let filterParameterValue = filterParameterValues[inputKey] as? CIVector, defaultVector.count != filterParameterValue.count
                {
                    filterParameterValues[inputKey] = defaultVector
                }
            }
        }
    }
    
    func supportedFilterNamesInCategory(category: String?) -> [String]
    {
        return CIFilter.filterNames(inCategory: category).filter
            {
                !exclusions.contains($0)
        }
    }
}

let CATEGORYCUSTOMFILTERS = "Custom Filters"
class CustomFiltersVendor: NSObject, CIFilterConstructor {
    func filter(withName name: String) -> CIFilter? {
        switch name {
        case RGBChannelCompositing.reuseIdentifier:
            return RGBChannelCompositing()
        case RGBChannelToneCurve.reuseIdentifier:
            return RGBChannelToneCurve()
        case RGBChannelBrightnessAndContrast.reuseIdentifier:
            return RGBChannelBrightnessAndContrast()
        default:
            return nil
        }
    }
    
    static func registerFilter() {
        CIFilter.registerName(RGBChannelCompositing.reuseIdentifier,
                              constructor: CustomFiltersVendor(),
                              classAttributes: [kCIAttributeFilterCategories: [CATEGORYCUSTOMFILTERS]])
        CIFilter.registerName(RGBChannelToneCurve.reuseIdentifier,
                              constructor: CustomFiltersVendor(),
                              classAttributes: [kCIAttributeFilterCategories: [CATEGORYCUSTOMFILTERS]])
        CIFilter.registerName(RGBChannelBrightnessAndContrast.reuseIdentifier,
                              constructor: CustomFiltersVendor(),
                              classAttributes: [kCIAttributeFilterCategories: [CATEGORYCUSTOMFILTERS]])
    }
    
}

/// `RGBChannelCompositing` filter takes three input images and composites them together
/// by their color channels, the output RGB is `(inputRed.r, inputGreen.g, inputBlue.b)`
extension NSObject{
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}

class RGBChannelCompositing: CIFilter
{
    @objc dynamic var inputRedImage : CIImage?
    @objc dynamic var inputGreenImage : CIImage?
    @objc dynamic var inputBlueImage : CIImage?
    
    let rgbChannelCompositingKernel = CIColorKernel(source:
        "kernel vec4 rgbChannelCompositing(__sample red, __sample green, __sample blue)" +
            "{" +
            "   return vec4(red.r, green.g, blue.b, 1.0);" +
        "}"
    )
    
    override var attributes: [String : Any]
    {
        return [
            kCIAttributeFilterDisplayName: "RGB Compositing",
            
            "inputRedImage": [kCIAttributeIdentity: 0,
                              kCIAttributeClass: "CIImage",
                              kCIAttributeDisplayName: "Red Image",
                              kCIAttributeType: kCIAttributeTypeImage],
            
            "inputGreenImage": [kCIAttributeIdentity: 0,
                                kCIAttributeClass: "CIImage",
                                kCIAttributeDisplayName: "Green Image",
                                kCIAttributeType: kCIAttributeTypeImage],
            
            "inputBlueImage": [kCIAttributeIdentity: 0,
                               kCIAttributeClass: "CIImage",
                               kCIAttributeDisplayName: "Blue Image",
                               kCIAttributeType: kCIAttributeTypeImage]
        ]
    }
    
    override var outputImage: CIImage!
    {
        guard let inputRedImage = inputRedImage,
            let inputGreenImage = inputGreenImage,
            let inputBlueImage = inputBlueImage,
            let rgbChannelCompositingKernel = rgbChannelCompositingKernel else
        {
            return nil
        }
        
        let extent = inputRedImage.extent.union(inputGreenImage.extent.union(inputBlueImage.extent))
        let arguments = [inputRedImage, inputGreenImage, inputBlueImage]
        
        return rgbChannelCompositingKernel.apply(extent: extent, arguments: arguments)
    }
}

/// `RGBChannelToneCurve` allows individual tone curves to be applied to each channel.
/// The `x` values of each tone curve are locked to `[0.0, 0.25, 0.5, 0.75, 1.0]`, the
/// supplied vector for each channel defines the `y` positions.
///
/// For example, if the `redValues` vector is `[0.2, 0.4, 0.6, 0.8, 0.9]`, the points
/// passed to the `CIToneCurve` filter will be:
/// ```
/// [(0.0, 0.2), (0.25, 0.4), (0.5, 0.6), (0.75, 0.8), (1.0, 0.9)]
/// ```
class RGBChannelToneCurve: CIFilter
{
    @objc dynamic var inputImage: CIImage?
    
    @objc dynamic var inputRedValues = CIVector(values: [0.0, 0.25, 0.5, 0.75, 1.0], count: 5)
    @objc dynamic var inputGreenValues = CIVector(values: [0.0, 0.25, 0.5, 0.75, 1.0], count: 5)
    @objc dynamic var inputBlueValues = CIVector(values: [0.0, 0.25, 0.5, 0.75, 1.0], count: 5)
    
    let rgbChannelCompositing = RGBChannelCompositing()
    
    override func setDefaults()
    {
        inputRedValues = CIVector(values: [0.0, 0.25, 0.5, 0.75, 1.0], count: 5)
        inputGreenValues = CIVector(values: [0.0, 0.25, 0.5, 0.75, 1.0], count: 5)
        inputBlueValues = CIVector(values: [0.0, 0.25, 0.5, 0.75, 1.0], count: 5)
    }
    
    override var attributes: [String : Any]
    {
        return [
            kCIAttributeFilterDisplayName: "RGB Tone Curve",
            
            "inputImage": [kCIAttributeIdentity: 0,
                           kCIAttributeClass: "CIImage",
                           kCIAttributeDisplayName: "Image",
                           kCIAttributeType: kCIAttributeTypeImage],
            
            "inputRedValues": [kCIAttributeIdentity: 0,
                               kCIAttributeClass: "CIVector",
                               kCIAttributeDefault: CIVector(values: [0.0, 0.25, 0.5, 0.75, 1.0], count: 5),
                               kCIAttributeDisplayName: "Red 'y' Values",
                               kCIAttributeDescription: "Red tone curve 'y' values at 'x' positions [0.0, 0.25, 0.5, 0.75, 1.0].",
                               kCIAttributeType: kCIAttributeTypeOffset],
            
            "inputGreenValues": [kCIAttributeIdentity: 0,
                                 kCIAttributeClass: "CIVector",
                                 kCIAttributeDefault: CIVector(values: [0.0, 0.25, 0.5, 0.75, 1.0], count: 5),
                                 kCIAttributeDisplayName: "Green 'y' Values",
                                 kCIAttributeDescription: "Green tone curve 'y' values at 'x' positions [0.0, 0.25, 0.5, 0.75, 1.0].",
                                 kCIAttributeType: kCIAttributeTypeOffset],
            
            "inputBlueValues": [kCIAttributeIdentity: 0,
                                kCIAttributeClass: "CIVector",
                                kCIAttributeDefault: CIVector(values: [0.0, 0.25, 0.5, 0.75, 1.0], count: 5),
                                kCIAttributeDisplayName: "Blue 'y' Values",
                                kCIAttributeDescription: "Blue tone curve 'y' values at 'x' positions [0.0, 0.25, 0.5, 0.75, 1.0].",
                                kCIAttributeType: kCIAttributeTypeOffset]
        ]
    }
    
    override var outputImage: CIImage!
    {
        guard let inputImage = inputImage else
        {
            return nil
        }
        
        let red = inputImage.applyingFilter("CIToneCurve",
                                            parameters: [
                                                "inputPoint0": CIVector(x: 0.0, y: inputRedValues.value(at: 0)),
                                                "inputPoint1": CIVector(x: 0.25, y: inputRedValues.value(at: 1)),
                                                "inputPoint2": CIVector(x: 0.5, y: inputRedValues.value(at: 2)),
                                                "inputPoint3": CIVector(x: 0.75, y: inputRedValues.value(at: 3)),
                                                "inputPoint4": CIVector(x: 1.0, y: inputRedValues.value(at: 4))
            ])
        
        let green = inputImage.applyingFilter("CIToneCurve",
                                              parameters: [
                                                "inputPoint0": CIVector(x: 0.0, y: inputGreenValues.value(at: 0)),
                                                "inputPoint1": CIVector(x: 0.25, y: inputGreenValues.value(at: 1)),
                                                "inputPoint2": CIVector(x: 0.5, y: inputGreenValues.value(at: 2)),
                                                "inputPoint3": CIVector(x: 0.75, y: inputGreenValues.value(at: 3)),
                                                "inputPoint4": CIVector(x: 1.0, y: inputGreenValues.value(at: 4))
            ])
        
        let blue = inputImage.applyingFilter("CIToneCurve",
                                             parameters: [
                                                "inputPoint0": CIVector(x: 0.0, y: inputBlueValues.value(at: 0)),
                                                "inputPoint1": CIVector(x: 0.25, y: inputBlueValues.value(at: 1)),
                                                "inputPoint2": CIVector(x: 0.5, y: inputBlueValues.value(at: 2)),
                                                "inputPoint3": CIVector(x: 0.75, y: inputBlueValues.value(at: 3)),
                                                "inputPoint4": CIVector(x: 1.0, y: inputBlueValues.value(at: 4))
            ])
        
        rgbChannelCompositing.inputRedImage = red
        rgbChannelCompositing.inputGreenImage = green
        rgbChannelCompositing.inputBlueImage = blue
        
        return rgbChannelCompositing.outputImage
    }
}

/// `RGBChannelBrightnessAndContrast` controls brightness & contrast per color channel
class RGBChannelBrightnessAndContrast: CIFilter
{
    @objc dynamic var inputImage: CIImage?
    
    @objc dynamic var inputRedBrightness: CGFloat = 0
    @objc dynamic var inputRedContrast: CGFloat = 1
    @objc dynamic var inputRedSaturation: CGFloat = 1
    
    @objc dynamic var inputGreenBrightness: CGFloat = 0
    @objc dynamic var inputGreenContrast: CGFloat = 1
    
    @objc dynamic var inputBlueBrightness: CGFloat = 0
    @objc dynamic var inputBlueContrast: CGFloat = 1
    
    let rgbChannelCompositing = RGBChannelCompositing()
    
    override func setDefaults()
    {
        inputRedBrightness = 0
        inputRedContrast = 1
        inputRedSaturation = 100
    
        
        inputGreenBrightness = 0
        inputGreenContrast = 1
        
        inputBlueBrightness = 0
        inputBlueContrast = 1
    }
    
    override var attributes: [String : Any]
    {
        return [
            kCIAttributeFilterDisplayName: "RGB Brightness And Contrast",
            
            "inputImage": [kCIAttributeIdentity: 0,
                           kCIAttributeClass: "CIImage",
                           kCIAttributeDisplayName: "Image",
                           kCIAttributeType: kCIAttributeTypeImage],
            
            "inputRedBrightness": [kCIAttributeIdentity: 0,
                                   kCIAttributeClass: "NSNumber",
                                   kCIAttributeDefault: 0,
                                   kCIAttributeDisplayName: "Red Brightness",
                                   kCIAttributeMin: 1,
                                   kCIAttributeSliderMin: -1,
                                   kCIAttributeSliderMax: 1,
                                   kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputRedContrast": [kCIAttributeIdentity: 0,
                                 kCIAttributeClass: "NSNumber",
                                 kCIAttributeDefault: 1,
                                 kCIAttributeDisplayName: "Red Contrast",
                                 kCIAttributeMin: 0.25,
                                 kCIAttributeSliderMin: 0.25,
                                 kCIAttributeSliderMax: 4,
                                 kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputRedSaturation": [kCIAttributeIdentity: 0,
                                 kCIAttributeClass: "NSNumber",
                                 kCIAttributeDefault: 1,
                                 kCIAttributeDisplayName: "Red Saturation",
                                 kCIAttributeMin: 0.25,
                                 kCIAttributeSliderMin: 0.25,
                                 kCIAttributeSliderMax: 4,
                                 kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputGreenBrightness": [kCIAttributeIdentity: 0,
                                     kCIAttributeClass: "NSNumber",
                                     kCIAttributeDefault: 0,
                                     kCIAttributeDisplayName: "Green Brightness",
                                     kCIAttributeMin: 1,
                                     kCIAttributeSliderMin: -1,
                                     kCIAttributeSliderMax: 1,
                                     kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputGreenContrast": [kCIAttributeIdentity: 0,
                                   kCIAttributeClass: "NSNumber",
                                   kCIAttributeDefault: 1,
                                   kCIAttributeDisplayName: "Green Contrast",
                                   kCIAttributeMin: 0.25,
                                   kCIAttributeSliderMin: 0.25,
                                   kCIAttributeSliderMax: 4,
                                   kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputBlueBrightness": [kCIAttributeIdentity: 0,
                                    kCIAttributeClass: "NSNumber",
                                    kCIAttributeDefault: 0,
                                    kCIAttributeDisplayName: "Blue Brightness",
                                    kCIAttributeMin: 1,
                                    kCIAttributeSliderMin: -1,
                                    kCIAttributeSliderMax: 1,
                                    kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputBlueContrast": [kCIAttributeIdentity: 0,
                                  kCIAttributeClass: "NSNumber",
                                  kCIAttributeDefault: 1,
                                  kCIAttributeDisplayName: "Blue Contrast",
                                  kCIAttributeMin: 0.25,
                                  kCIAttributeSliderMin: 0.25,
                                  kCIAttributeSliderMax: 4,
                                  kCIAttributeType: kCIAttributeTypeScalar]
        ]
    }
    
    override var outputImage: CIImage!
    {
        guard let inputImage = inputImage else
        {
            return nil
        }
        
        let red = inputImage.applyingFilter("CIColorControls",
                                            parameters: [
                                                    kCIInputBrightnessKey: inputRedBrightness,
                                                    kCIInputContrastKey: inputRedContrast,
                                                    kCIInputSaturationKey: inputRedSaturation])
        
        let green = inputImage.applyingFilter("CIColorControls",
                                              parameters: [
                                                        kCIInputBrightnessKey: inputGreenBrightness,
                                                        kCIInputContrastKey: inputGreenContrast])
        
        let blue = inputImage.applyingFilter("CIColorControls",
                                             parameters: [
                                                        kCIInputBrightnessKey: inputBlueBrightness,
                                                        kCIInputContrastKey: inputBlueContrast])
        
        rgbChannelCompositing.inputRedImage = red
        rgbChannelCompositing.inputGreenImage = green
        rgbChannelCompositing.inputBlueImage = blue
        
        let finalImage = rgbChannelCompositing.outputImage
        
        return finalImage
    }
}


