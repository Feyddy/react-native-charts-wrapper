//
//  PieFormatter.swift
//  Charts
//
import Foundation
import Charts
@objc(PieFormatter)
open class PieFormatter: NSObject, IValueFormatter
{
    public typealias Block = (
        _ value: Double,
        _ entry: ChartDataEntry,
        _ dataSetIndex: Int,
        _ viewPortHandler: ViewPortHandler?) -> String
    @objc open var block: Block?
    @objc open var hasAutoDecimals: Bool = false
    private var _formatter: NumberFormatter?
    @objc open var formatter: NumberFormatter?
    {
        get { return _formatter }
        set
        {
            hasAutoDecimals = false
            _formatter = newValue
        }
    }
    private var _decimals: Int?
    open var decimals: Int?
    {
        get { return _decimals }
        set
        {
            _decimals = newValue
            if let digits = newValue
            {
                self.formatter?.minimumFractionDigits = digits
                self.formatter?.maximumFractionDigits = digits
                self.formatter?.usesGroupingSeparator = true
            }
        }
    }
    public override init()
    {
        super.init()
        self.formatter = NumberFormatter()
        hasAutoDecimals = true
    }
    @objc public init(formatter: NumberFormatter)
    {
        super.init()
        self.formatter = formatter
    }
    @objc public init(decimals: Int)
    {
        super.init()
        self.formatter = NumberFormatter()
        self.formatter?.usesGroupingSeparator = true
        self.decimals = decimals
        hasAutoDecimals = true
    }
    @objc public init(block: @escaping Block)
    {
        super.init()
        self.block = block
    }
    @objc public static func with(block: @escaping Block) -> DefaultValueFormatter?
    {
        return DefaultValueFormatter(block: block)
    }
    open func stringForValue(_ value: Double,
                             entry: ChartDataEntry,
                             dataSetIndex: Int,
                             viewPortHandler: ViewPortHandler?) -> String
    {
        if let block = block {
            return block(value, entry, dataSetIndex, viewPortHandler)
        } else {
            print("Pie format111= \(NSNumber(floatLiteral: value))==\(entry.y)")
            var str1 : String = ""
            let num = Int(entry.y)
            str1 = formatter?.string(from: NSNumber(floatLiteral: value)) ?? ""
            return (str1.isEmpty) ? "" : str1+String(", \(num)")
        }
    }
}
