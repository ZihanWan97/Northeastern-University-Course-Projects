/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UIDesign;

import com.formdev.flatlaf.extras.FlatSVGIcon;
import javax.swing.JLabel;

/**
 *
 * @author Eva
 */
public class SVGImage extends JLabel{
    private FlatSVGIcon svgIcon;
    public void setSvgImage(String image, int width, int height){
        svgIcon = new FlatSVGIcon(image, width, height);
        setIcon(svgIcon);
    }
    
}
