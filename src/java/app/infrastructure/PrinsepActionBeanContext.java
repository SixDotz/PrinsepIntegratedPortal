/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.infrastructure;

import app.model.User;
import javax.servlet.http.HttpSession;
import net.sourceforge.stripes.action.ActionBeanContext;
//import net.sourceforge.stripes.action.Message;

/**
 *
 * @author Lim
 */
public class PrinsepActionBeanContext extends ActionBeanContext {

    private static final String FOLDER = "folder";
    private static final String MESSAGE = "message";
    private static final String USER = "user";

//    public void setCurrentFolder(Folder folder) {
//        setCurrent(FOLDER, folder.getId());
//    }
//
//    public Folder getCurrentFolder() {
//        FolderDao folderDao = new FolderDaoImpl();
//        Folder folder = null;
//        Integer folderId = getCurrent(FOLDER, null);
//        if (folderId != null) {
//            folder = folderDao.read(folderId);
//        } else {
//            folder = folderDao.findByName(Folder.INBOX, getUser());
//        }
//        return folder;
//    }
//    public void setMessageCompose(Message message) {
//        setCurrent(MESSAGE, message);
//    }

//    public Message getMessageCompose() {
//        return getCurrent(MESSAGE, new Message());
//    }
//    
    public void setUser(User user) {
        if (user != null) {
            setCurrent(USER, user);
        } else {
            setCurrent(USER, null);
        }
    }

    public User getUser() {
        //        Integer userId = getCurrent(USER, null);
        //        if (userId == null) {
        //            return null;
        //        }
        //        return new UserDaoImpl().read(userId);

        return getCurrent(USER, null);
    }

    public void logout() {
        setUser(null);

        HttpSession session = getRequest().getSession();
        if (session != null) {
            session.invalidate();
        }
    }

    protected void setCurrent(String key, Object value) {
        getRequest().getSession().setAttribute(key, value);
    }

    @SuppressWarnings("unchecked")
    protected <T> T getCurrent(String key, T defaultValue) {
        T value = (T) getRequest().getSession().getAttribute(key);
        if (value == null) {
            value = defaultValue;
            setCurrent(key, value);
        }
        return value;
    }
}
