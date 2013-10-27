/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package app.infrastructure;

import app.action.*;
import java.util.Arrays;
import java.util.List;
import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.controller.ExecutionContext;
import net.sourceforge.stripes.controller.Interceptor;
import net.sourceforge.stripes.controller.Intercepts;
import net.sourceforge.stripes.controller.LifecycleStage;

/**
 *
 * @author Lim
 */
@Intercepts(LifecycleStage.ActionBeanResolution)
public class LoginInterceptor implements Interceptor {

    @SuppressWarnings("unchecked")
    private static final List<Class<? extends BaseActionBean>> ALLOW =
        Arrays.asList(
            LoginActionBean.class,
            CommLifeActionBean.class,
            HostelEventsActionBean.class,
            LetsGoEventsActionBean.class,
            LetsGoEventsDetailsActionBean.class,
            SampleActionBean.class
        );

    public Resolution intercept(ExecutionContext execContext)
            throws Exception {
        Resolution resolution = execContext.proceed();

        //PrinsepActionBeanContext ctx = (PrinsepActionBeanContext) execContext.getActionBeanContext();
        ActionBeanContext ctx = execContext.getActionBeanContext();

        BaseActionBean actionBean = (BaseActionBean) execContext.getActionBean();

        Class<? extends ActionBean> cls = actionBean.getClass();

        //if (ctx.getUser() == null && !ALLOW.contains(cls)) {
        if (ctx.getRequest().getSession().getAttribute("user") == null && !ALLOW.contains(cls)) {
            resolution = new RedirectResolution(CommLifeActionBean.class);
            if (ctx.getRequest().getMethod().equalsIgnoreCase("GET")) {
                ((RedirectResolution) resolution).addParameter("loginUrl", actionBean.getLastUrl());
            }
        }
        return resolution;
    }
}
