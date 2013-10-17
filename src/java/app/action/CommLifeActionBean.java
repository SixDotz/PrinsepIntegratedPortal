/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.action;

/**
 *
 * @author Lim
 */
import app.infrastructure.BaseActionBean;
import app.model.HostelEvent;
import app.model.dataaccess.HostelEventDA;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import net.sourceforge.stripes.action.*;

public class CommLifeActionBean extends BaseActionBean {
    // <editor-fold defaultstate="collapsed" desc="ActionBean Property Objects">
    private ArrayList<HostelEvent> hostelEventHighlights;
    
    public List<HostelEvent> getHostelEventHighlights() {
        ArrayList<HostelEvent> lst = hostelEventHighlights;

        //Call data access to retrieve hostel event highlights
        // HostelEventDA hostelEventDA = new HostelEventDA();
        //lst = hostelEventDA.getValidHostelEvent_Highlight();

        if (lst == null) {
            lst = new ArrayList<HostelEvent>();

            lst.add(new HostelEvent(1, "Beerloween", new Date(), null, "CourtYard", "Drink & Be Merry", "Beerloween.jpg", "Beerloween_Small.jpg", "", true, null));
            lst.add(new HostelEvent(2, "EarthHr", new Date(), null, "CourtYard", "Drink & Be Merry", "EarthHr.png", "EarthHr_Small.png", "", true, null));
            lst.add(new HostelEvent(3, "HoliFestival", new Date(), null, "CourtYard", "Drink & Be Merry", "HoliFestival.jpg", "HoliFestival_Small.jpg", "", true, null));
            lst.add(new HostelEvent(4, "Prinsepatop3", new Date(), null, "CourtYard", "Drink & Be Merry", "Prinsepatop3.jpg", "Prinsepatop3_Small.jpg", "", true, null));
            lst.add(new HostelEvent(5, "SWAGBeerNight", new Date(), null, "CourtYard", "Drink & Be Merry", "SWAGBeerNight.jpg", "SWAGBeerNight_Small.jpg", "", true, null));
        }

        return lst;
    }
    // </editor-fold>

    public CommLifeActionBean() {
        super("/WEB-INF/jsp/Index.jsp");
    }

    public Resolution index() {
        //Return JSP Page
        return new ForwardResolution(getView());
    }
}
