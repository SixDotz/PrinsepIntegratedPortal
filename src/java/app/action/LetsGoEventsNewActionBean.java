/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.action;

import app.infrastructure.BaseActionBean;
import app.model.User;
import app.model.dataaccess.LetsGoEventDA;
import app.viewmodel.NewLetsGoForm;
import java.util.Calendar;
import java.util.Date;
import net.sourceforge.stripes.action.*;
import net.sourceforge.stripes.validation.*;

/**
 *
 * @author Joyceee
 */
public class LetsGoEventsNewActionBean extends BaseActionBean implements
        ValidationErrorHandler {

    // do standard validation
    @ValidateNestedProperties({
        @Validate(field = "title", required = true, on = "createLetsGo"),
        @Validate(field = "category", required = true, on = "createLetsGo")})
    private NewLetsGoForm newLetsGoForm;

    public NewLetsGoForm getNewLetsGoForm() {
        return newLetsGoForm;
    }

    public void setNewLetsGoForm(NewLetsGoForm newLetsGoForm) {
        this.newLetsGoForm = newLetsGoForm;
    }

    public LetsGoEventsNewActionBean() {
        super("/WEB-INF/jsp/LetsGoEvents_NewLetsGo.jsp");
    }

    public Resolution index() {
        System.out.println("Or i am at the index method?");
        return new ForwardResolution(getView());
    }

    public Resolution createLetsGo() {
        //Getting all the objects from the form
        String title = newLetsGoForm.getTitle();
        int category = newLetsGoForm.getCategory();
        String date = newLetsGoForm.getDate();
        String time = newLetsGoForm.getTime();
        String venue = newLetsGoForm.getVenue();
        int maxCap = newLetsGoForm.getCapacity();
        String contact = newLetsGoForm.getContact();
        String details = newLetsGoForm.getDetails();
        //MISSING: List of invited friends

        //Getting user ID
        User user = this.getUser();
        int userID = user.getUserID();

        //Getting the components of date
        String[] dateStr = date.split("/");
        String[] timeStr = time.split(":");
        String hourStr = timeStr[0];
        String minStr = timeStr[1].substring(0, 2);

        //Change string date to integer
        int year = Integer.parseInt(dateStr[2]);
        int month = Integer.parseInt(dateStr[0]) - 1;
        int day = Integer.parseInt(dateStr[1]);
        int hour = Integer.parseInt(hourStr);
        int min = Integer.parseInt(minStr);

        //convert to date object
        Calendar cal = Calendar.getInstance();
        cal.set(year, month, day, hour, min, 0);
        Date dateCal = cal.getTime();

        //Create new data access object
        LetsGoEventDA da = new LetsGoEventDA();

        //Insert new event into database
        da.insertNewEvent(userID, title, category, dateCal, venue, maxCap, details, contact, "thisIsAPhotoUrlHahaha");

        //Redirect users back to LetsGoEvent page
        return new RedirectResolution(LetsGoEventsActionBean.class);
    }

    @Override
    public Resolution handleValidationErrors(ValidationErrors errors)
            throws Exception {
        String error = "Error: Missing details.\n";
        return new StreamingResolution("text/html", error);
    }
}
