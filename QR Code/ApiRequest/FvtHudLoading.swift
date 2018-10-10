import UIKit
enum HudTypes{
    case defaultType
    case roundRotation
}
class FVTHud:NSObject
{
    static var hudContainderSize:CGFloat = 160 // Size of container which holds all stuff
    
    static var hudType:HudTypes = .roundRotation // Type of hud
    
    static var rotationLineWidth:CGFloat = 3 // line which is rotating
    
    static var rotaionGapPercentage:CGFloat = 90 // The gap which appears in round rotating line
    
    static var rotationSpeedTime:TimeInterval = 2 // Speed of rotation
    static var rotationSizeRatio:CGFloat = 2 // This is the size ration of round rotating line, By default it is half of total hud size that is hudContainderSize
    
    static var rotationLineColor:UIColor = .gray // Color of rotating line
    static var rotationLineGapColor:UIColor = .clear // Color of the gap which appears in round rotating line
    
    static var showNetworkIndicator:Bool = true // At the top or on the status bar there is default network indicator
    
    fileprivate static var isAnimating = false
    
    
    static let disablerView:UIView={
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.15)
        return view
    }()
    static let hudContainder:UIImageView={
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        return view
    }()
    static var loadingIndicator:UIActivityIndicatorView={
        let loading = UIActivityIndicatorView()
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.activityIndicatorViewStyle = .whiteLarge
        loading.backgroundColor = .clear
        loading.layer.cornerRadius = 16
        loading.layer.masksToBounds = true
        return loading
    }()
    
    static var hudTextsLabel:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Loading..."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let rotationRoundBackground:UIView={ // This is the view which is containing the rotating line
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate static var timerToHideHud:Timer?
    fileprivate static var timerToShowHud:Timer?
    
    @objc class func hideHudAfterDelay(timeInterval:Double){
        
        FVTHud.timerToShowHud?.invalidate()
        FVTHud.timerToHideHud = Timer.scheduledTimer(timeInterval: timeInterval, target: FVTHud.self, selector: #selector(FVTHud.hide), userInfo: nil, repeats: false)
        
    }
    
    @objc class func hide(){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        isAnimating = false
        FVTHud.loadingIndicator.stopAnimating()
        FVTHud.disablerView.removeFromSuperview()
        timerToHideHud?.invalidate()
        
    }
    
    
    class func showHudAfterDelay(timeInterval:Double,hudTexts:String = "Loading...",conainerView:Any? = nil)
    {
        FVTHud.hudTextsLabel.text = hudTexts
        FVTHud.timerToHideHud?.invalidate()
        
        FVTHud.timerToShowHud = Timer.scheduledTimer(timeInterval: timeInterval, target: FVTHud.self, selector: #selector(FVTHud.showHudAfterDelayWithPatameter), userInfo: ["hudTexts":hudTexts,"view":conainerView], repeats: false)
    }
    
    @objc fileprivate static func showHudAfterDelayWithPatameter(timer:Timer){
        if let userInfo = timer.userInfo as? [String:Any]{
            var conainerView:UIView?
            if let value = userInfo["view"] as? UIView{
                conainerView = value
            }
            if let value = userInfo["hudTexts"] as? String{
                showHud(hudTexts: value, hudConainerView: conainerView)
            }
        }
    }
    
    @objc static func showHud(hudTexts:String = "Loading...",hudConainerView:UIView? = nil){
        
        FVTHud.hudTextsLabel.text = hudTexts
        func setUpHudeViews(keyWindow:UIView){
            
            if !isAnimating
            {
                isAnimating = true
                UIApplication.shared.isNetworkActivityIndicatorVisible = showNetworkIndicator
                keyWindow.addSubview(disablerView)
                
                disablerView.rightAnchor.constraint(equalTo: keyWindow.rightAnchor).isActive = true
                disablerView.leftAnchor.constraint(equalTo: keyWindow.leftAnchor).isActive = true
                disablerView.topAnchor.constraint(equalTo: keyWindow.topAnchor).isActive = true
                disablerView.bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor).isActive = true
                FVTHud.loadingIndicator.startAnimating()
                
                disablerView.addSubview(hudContainder)
                hudContainder.addSubview(hudTextsLabel)
                
                hudContainder.centerXAnchor.constraint(equalTo: disablerView.centerXAnchor).isActive = true
                hudContainder.centerYAnchor.constraint(equalTo: disablerView.centerYAnchor).isActive = true
                hudContainder.widthAnchor.constraint(equalToConstant: hudContainderSize).isActive = true
                hudContainder.heightAnchor.constraint(equalToConstant: hudContainderSize).isActive = true
                
                if hudType == .defaultType{
                    hudContainder.addSubview(loadingIndicator)
                    loadingIndicator.centerXAnchor.constraint(equalTo: hudContainder.centerXAnchor).isActive = true
                    loadingIndicator.centerYAnchor.constraint(equalTo: hudContainder.centerYAnchor).isActive = true
                    hudTextsLabel.topAnchor.constraint(equalTo: loadingIndicator.bottomAnchor, constant: 5).isActive = true
                }else{
                    
                    let roatationViewSize:CGFloat = hudContainderSize/rotationSizeRatio
                    hudContainder.addSubview(rotationRoundBackground)
                    rotationRoundBackground.heightAnchor.constraint(equalToConstant:roatationViewSize).isActive = true
                    rotationRoundBackground.widthAnchor.constraint(equalToConstant:roatationViewSize).isActive = true
                    rotationRoundBackground.layer.masksToBounds = true
                    let halfSize:CGFloat = roatationViewSize/2
                    rotationRoundBackground.layer.cornerRadius = halfSize
                    rotationRoundBackground.centerXAnchor.constraint(equalTo: hudContainder.centerXAnchor).isActive = true
                    rotationRoundBackground.centerYAnchor.constraint(equalTo: hudContainder.centerYAnchor).isActive = true
                    hudTextsLabel.topAnchor.constraint(equalTo: rotationRoundBackground.bottomAnchor, constant: 5).isActive = true
                    
                    func getShapeLayer(color:UIColor,view:UIView,gap:Double){
                        let circlePath = UIBezierPath(
                            arcCenter: CGPoint(x:halfSize,y:halfSize),
                            radius: CGFloat( halfSize - (rotationLineWidth/2)),
                            startAngle: CGFloat(0),
                            endAngle:CGFloat(Double.pi * gap),
                            clockwise: true)
                        let shapeLayer = CAShapeLayer()
                        shapeLayer.path = circlePath.cgPath
                        shapeLayer.fillColor = UIColor.clear.cgColor
                        shapeLayer.strokeColor = color.cgColor
                        shapeLayer.lineWidth = rotationLineWidth
                        view.layer.addSublayer(shapeLayer)
                    }
                    
                    getShapeLayer(color: rotationLineGapColor, view: rotationRoundBackground,gap: 2)
                    getShapeLayer(color: rotationLineColor, view: rotationRoundBackground,gap: (Double((rotaionGapPercentage * 2)/100)))
                    let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
                    rotateAnimation.fromValue = 0.0
                    rotateAnimation.toValue = CGFloat(Double.pi * 2)
                    rotateAnimation.isRemovedOnCompletion = false
                    rotateAnimation.duration = rotationSpeedTime
                    rotateAnimation.repeatCount=Float.infinity
                    rotationRoundBackground.layer.add(rotateAnimation, forKey: nil)
                }
                
                hudTextsLabel.rightAnchor.constraint(equalTo: hudContainder.rightAnchor, constant: -3).isActive = true
                hudTextsLabel.leftAnchor.constraint(equalTo: hudContainder.leftAnchor, constant: 3).isActive = true
                hudTextsLabel.bottomAnchor.constraint(equalTo: hudContainder.bottomAnchor, constant: -5).isActive = true
                
            }
            
        }
        
        if let superView = hudConainerView{
            setUpHudeViews(keyWindow: superView)
        }else if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window,let keyWindow = window.rootViewController?.view {
            setUpHudeViews(keyWindow: keyWindow)
        }
    }
    
}
